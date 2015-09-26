;;OUR SCHEME INTERPRETER 
;;---------------------------------------------------------------------------

;; An expression exp is either
;; 1. (make-definition var val) where var is a symbol and val is an exp
;; 2. (make-proc params exp) where params is a list-of-symbols 
;;     and exp is an exp
;; 3. (make-if-clause predicate c a) where predicate, c and a are exp
;; 4. (make-application operator operands) where operator is an exp 
;;     and operands is (listof exp)
;; 5. (make-variable n) where n is a symbol
;; 6. a number or a boolean or a string
(define-struct definition (variable value))
(define-struct proc (parameters exp))
(define-struct if-clause (predicate consequent alternative))
(define-struct application (operator operands))
(define-struct variable (name))

;; parse converts an s-expression into an exp structure
;; parse : s-expression -> exp
(define (parse sexp)
  (cond [(number? sexp) sexp]
        [(string? sexp) sexp]
        [(boolean? sexp) sexp]
        [(symbol? sexp) (make-variable sexp)]
        [(cons? sexp)
         (local ((define op (first sexp)))
           (cond 
             [(and (symbol? op) (symbol=? op 'lambda)) 
              (make-proc (second sexp) (parse (third sexp)))]
             [(and (symbol? op) (symbol=? op 'if)) 
              (make-if-clause 
               (parse (second sexp)) 
               (parse (third sexp)) 
               (parse (fourth sexp)))]
             [(and (symbol? op) (symbol=? op 'define)) 
              (make-definition (second sexp) (parse (third sexp)))]
             [else (make-application (parse (first sexp)) 
                                     (map parse (rest sexp)))]))]))

;; map data-structure

;; hidden from users of map
(define-struct binding (name value)) 

;; map-create: (listof symbol) (listof X) -> (mapof X)
(define (map-create names values) (map make-binding names values))

;; map-extend: symbol X (mapof X) -> (mapof X)
(define (map-extend var val base-env)
  (cons (make-binding var val) base-env))

;; map-remove: symbol (mapof X) -> (mapof X)
(define (map-remove name a-map)
  (filter (lambda (b) (not (symbol=? name (binding-name b)))) 
          a-map))

;; map-remove-all: (listof symbol) (mapof X) -> (mapof X)
(define (map-remove-all names a-map)
  (foldr map-remove a-map names))

;; map-lookup: symbol (mapof X) -> X or empty
(define (map-lookup name a-map)
  (if (empty? a-map)
      empty
      (if (symbol=? name (binding-name (first a-map)))
          (binding-value (first a-map))
          (map-lookup name (rest a-map)))))


(define-struct primitive-procedure (the-proc))
  
;; A value val is either
;; 1. a number
;; 2. a String
;; 3. a Boolean
;; 4. (make-proc params exp) where params is a list-of-symbols
;;    and exp is an exp
;; 5. (make-primitive-procedure p) where p is a Scheme procedure
;; all values are self-evaluating
;; self-evaluating :: exp -> boolean
(define (self-evaluating? exp)
    (cond [(number? exp) true]
          [(string? exp) true]
          [(boolean? exp) true]
          [(proc? exp) true]  ;; procedures are self-evaluating!!
          [(primitive-procedure? exp) true]
          [else false]))

;; evaluates a variable by looking it up in the environment
;; eval-var :: exp env -> val
(define (eval-var exp env)
  (local ((define val (map-lookup (variable-name exp) env)))
    (if (empty? val) 
        (error 'eval-var 
               (format "Unbound variable: ~v" (variable-name exp)))
        val)))
  
;; eval-if : exp env -> val
(define (eval-if exp env)
  (if (eval (if-clause-predicate exp) env)
      (eval (if-clause-consequent exp) env)
      (eval (if-clause-alternative exp) env)))

(define (subst a-map exp)
  (cond 
    [(proc? exp) 
     (make-proc 
       (proc-parameters exp) 
       (subst 
         (map-remove-all (proc-parameters exp) a-map) 
         (proc-exp exp)))]
    [(self-evaluating? exp) exp]
    [(variable? exp) 
      (local ((define newval 
                    (map-lookup (variable-name exp) a-map)))
         (if (empty? newval) exp newval))]
    [(if-clause? exp) 
      (make-if-clause 
        (subst a-map (if-clause-predicate exp))
        (subst a-map (if-clause-consequent exp))
        (subst a-map (if-clause-alternative exp)))]
    [(application? exp) 
     (make-application
        (subst a-map (application-operator exp))
        (map (lambda (op) (subst a-map op)) 
             (application-operands exp)))]
    [else
       (error 'subst (format "Unknown expression type: ~v" exp))]))

(define primitive-procedures
  (local
    ;;added sin and cos as names for 
    ((define names     
            '(first rest cons list empty? empty * / - + < = abs))
     ;;builtin sin and cos function
     (define procs 
        (list first rest cons list empty? empty * / - + < = abs)))
      (map-create names (map make-primitive-procedure procs)))) 

;; eval-app: val (listof exp) env -> val
(define (eval-app procedure arguments env)
    (cond [(primitive-procedure? procedure)
           (apply 
            (primitive-procedure-the-proc procedure) 
            (map (lambda (expr) (eval expr env)) arguments))]
          [(proc? procedure) 
           (eval
             (subst 
               (map-create  
                 (proc-parameters procedure) 
                 arguments)
               (proc-exp procedure))
             env)] 
          [else
           (error
            'eval-app
            (format "Procedure expected, found: ~v" procedure))]))

;; eval evaluates an expression exp in an environment env
;; eval : exp env -> val
(define (eval exp env)
  (cond [(self-evaluating? exp) exp]
        [(variable? exp) (eval-var exp env)]
        [(if-clause? exp) (eval-if exp env)]
        [(application? exp)
         (eval-app
          (eval (application-operator exp) env) 
          (application-operands exp)
          env)]
        [else
           (error 'eval 
                  (format "Unknown expression type: ~v" exp))]))


 
 ;; run-prog :: prog env -> (listof val)
  (define (run-prog prog env)
    (if (empty? prog)
        empty
        (local ((define exp (parse (first prog))))
          (if (definition? exp)
              (run-prog
               (rest prog)
               (map-extend 
                (definition-variable exp)
                (eval (definition-value exp) env)
                env))
              (cons 
               (eval exp env)
               (run-prog (rest prog) env))))))
               
               
;;OUR SCHEME INTERPRETER 
;;---------------------------------------------------------------------------
               

;;TEST PROGRAM
;;---------------------------------------------------------------------------
(define testprog
 '((define my-cons (lambda (x y) (lambda (n) (if (= n 0) x y))))
   (define my-first (lambda (p) (p 0)))
   (define my-rest (lambda (p) (p 1)))
   (define repeat (lambda (f a) (my-cons a (repeat f (f a)))))
   ...))

(run-prog testprog primitive-procedures)

