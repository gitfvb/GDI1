;;struct for storing (directed) graph edges
(define-struct edge (start end))

(define samplegraph 
  (list 
   (make-edge 'a 'b)
   (make-edge 'b 'a)
   (make-edge 'a 'a)
   (make-edge 'a 'c)
   (make-edge 'b 'c)))


;;helper function contains?
;:returns whether sym is contained in a list of symbols
;;contract: contains: symbol list-of-symbols -> boolean
::example: (contains-symbol? 'a (1 2 3 4)) -> false
::example: (contains? 'a '(a b c d)) -> true
(define (contains? sym alos)
  (foldl (lambda (x c) (or (symbol=? sym x) c)) false alos))



(define (neighbors n G)
...)

;(neighbors 'a samplegraph)
;(neighbors 'b samplegraph)
;(neighbors 'c samplegraph)



