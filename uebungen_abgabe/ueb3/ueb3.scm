;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ueb3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

;;================================================
;; Übungsgruppe GDI 1 bei Florian Reith
;; ------------------------------------
;; 
;; WS 2008/2009
;; Florian Friedrichs
;; Übung 3
;;
;;================================================


;;recursive datastructure for trees
(define-struct treenode (left content right))

;;structure for the content of ptrees
(define-struct ptree-node (s p))

;;frequency of letters in english texts
(define freq (list
              (make-ptree-node 'a 0.0651738)
              (make-ptree-node 'b 0.0124248)
              (make-ptree-node 'c 0.0217339)
              (make-ptree-node 'd 0.0349835)
              (make-ptree-node 'e 0.1041442)
              (make-ptree-node 'f 0.0197881)
              (make-ptree-node 'g 0.0158610)
              (make-ptree-node 'h 0.0492888)
              (make-ptree-node 'i 0.0558094)
              (make-ptree-node 'j 0.0009033)
              (make-ptree-node 'k 0.0050529)
              (make-ptree-node 'l 0.0331490)
              (make-ptree-node 'm 0.0202124)
              (make-ptree-node 'n 0.0564513)
              (make-ptree-node 'o 0.0596302)
              (make-ptree-node 'p 0.0137645)
              (make-ptree-node 'q 0.0008606)
              (make-ptree-node 'r 0.0497563)
              (make-ptree-node 's 0.0515760)
              (make-ptree-node 't 0.0729357)
              (make-ptree-node 'u 0.0225134)
              (make-ptree-node 'v 0.0082903)
              (make-ptree-node 'w 0.0171272)
              (make-ptree-node 'x 0.0013692)
              (make-ptree-node 'y 0.0145984)
              (make-ptree-node 'z 0.0007836)
              (make-ptree-node 'space 0.1918182)))


;;a very simple codetree for testing purposes
(define simplecode 
  (make-treenode 
   (make-treenode 
    (make-treenode empty 'a empty) 
    'unused 
    (make-treenode empty 'b empty))
   'unused
   (make-treenode
    (make-treenode empty 'c empty) 
    'unused 
    (make-treenode empty 'd empty))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;helper function for turning ptree-nodes into one-element trees.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: ptree-node-or-ptree -> ptree
;;purpose: turns ptree-nodes into trees
;;example: (make-subtree  (make-treenode empty (make-ptree-node 'l 0.0331490) empty) -> 
;;              (make-treenode empty (make-ptree-node 'l 0.0331490) empty)
(define (make-subtree ptree-node-or-ptree)
  (if (treenode? ptree-node-or-ptree) ptree-node-or-ptree (make-treenode empty ptree-node-or-ptree empty)))

;;TEST
(check-expect 
 (make-subtree (make-ptree-node 'm 0.0202124))
 (make-treenode empty (make-ptree-node 'm 0.0202124) empty))

;;TEST
(check-expect 
 (make-subtree (make-treenode empty (make-ptree-node 'm 0.0202124) empty))
 (make-treenode empty (make-ptree-node 'm 0.0202124) empty))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: contains? : symbol treenode -> boolean
;;purpose: Prüfung auf Vorhandensein eines Symbols in einem Baum
;;         mit beliebig vielen Blättern.
;;example: 

(define (contains? sym tree)
  (cond
    ;; Rekursionsanker
    [(empty? (treenode-content tree)) empty]
    ;; Fehler prüfen
    [(not (symbol? sym))    "Fehler: ungültige Symbol"]
    [(not (treenode? tree)) "Fehler: ungültiger Baum"]
    ;; inhalte prüfen
    [(and (symbol? (treenode-content tree)) (symbol=? (treenode-content tree) sym)) true]    ;; content
    [(and (treenode? (treenode-left tree)) (contains? sym (treenode-left tree))) true] ;; links
    [(and (treenode? (treenode-right tree)) (contains? sym (treenode-right tree))) true] ;; rechts
    [else false]            
    )
  )

;;TEST
(check-expect 
 (contains? 'e simplecode)
 false)

;;TEST
(check-expect
 (contains? 'c simplecode) 
 true)

;; OWN TEST
(check-expect
 (contains? 'a simplecode)
 true)

(check-expect
 (contains? 'z simplecode)
 false)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: encode : symbol treenode -> list-of-numbers
;;purpose: Berechnung der binären Codierung eines Symbols.
;;         Ist das Symbol im linken Ast enthalten, wird der Liste eine 0 hinzugefügt.
;;         Ist das Symbol im rechten Ast enthalten, wird der Liste eine 1 hinzugefügt.
;;example:

(define (encode sym tree)
  (cond
    ;; Rekursionsanker
    [(empty? (treenode-content tree)) empty]
    ;; Fehler
    [(not (symbol? sym)) "Fehler: ungültiges Symbol"]
    [(not (treenode? tree)) "Fehler: ungültiger Baum"]
    ;; Inhalte prüfen
    [(symbol=? (treenode-content tree) sym) empty]
    [(contains? sym (treenode-left tree))  (append (list 0) (encode sym (treenode-left tree)))]
    [(contains? sym (treenode-right tree)) (append (list 1) (encode sym (treenode-right tree)))]
    [else "Fehler in der Verarbeitung."]    
    )
  )

;;TEST
(check-expect 
 (encode 'a simplecode)
 (list 0 0))

;;TEST
(check-expect 
 (encode 'd simplecode)
 (list 1 1))

;; OWN TEST
(check-expect
 (encode 'c simplecode)
 (list 1 0))

(check-expect
 (encode 5 simplecode)
 "Fehler: ungültiges Symbol")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: encode-list : list-of-symbols treenode -> list(list-of-numbers)
;;purpose: Verarbeitung einer Liste (bestehend aus Symbolen) zu einer Liste
;;         mit codierten Symbolen. Dazu wird die Funktion encode aufgerufen.
;;example: 

(define (encode-list los lot)  
  (cond
    ;; Rekursionsanker
    [(empty? los) empty]
    ;; Fehlercheck
    [(not (symbol? (first los))) "Fehler: Liste enthält nicht nur Symbole."]
    ;; Prozedur
    [else (append (list (encode (first los) lot)) (encode-list (rest los) lot))]
    )
  )

;;TEST
(check-expect 
 (encode-list '(a d) simplecode)
 (list (list 0 0) (list 1 1)))

;; OWN TEST
(check-expect
 (encode-list '(c z) simplecode)
 (list (list 1 0) "Fehler in der Verarbeitung."))

(check-expect
 (encode-list '(a d c) simplecode)
 (list (list 0 0) (list 1 1) (list 1 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;some ptrees for testing purposes
(define ptree1 (make-treenode empty (make-ptree-node 'a 0.1) empty))
(define ptree2 (make-treenode empty (make-ptree-node 'b 0.2) empty))
(define ptree3 (make-treenode empty (make-ptree-node 'c 0.3) empty))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: make-subtree-list : (list-of-ptree-node or treenode) -> treenode
;;purpose: Anwendung von make-subtree auf alle Elemente einer übergebenen Liste.
;;example: 

(define (make-subtree-list lop)
  (cond
    ;; Rekursionsanker
    [(empty? lop) empty]
    ;; Fehlerprüfung
    [(not (or 
           (treenode? (first lop))
           (ptree-node? (first lop))))
     "Fehler: Keine gültige Eingabe."]
    ;; Erweiterung der Listen / Rekursionsaufruf (der eigentliche Prozess)
    [else
     (cons
      (make-subtree (first lop))
      (make-subtree-list (rest lop))
      )]
    )
  )

;;TEST
(check-expect 
 (make-subtree-list (list ptree1 (make-ptree-node 'b 0.2)))
 (list ptree1 ptree2))

;; OWN TESTS
(check-expect 
 (make-subtree-list (list ptree1 (make-ptree-node 'c 0.3)))
 (list ptree1 ptree3))

(check-expect
 (make-subtree-list (list ptree2 (make-ptree-node 'c 0.3)))
 (list ptree2 ptree3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: sort-ptree-list :  -> list-of-ptree-node
;;purpose:  Sortieren des übergebenen Baumes nach der Wahrscheinlichkeit der Blätter.
;;example:     0.8      0.7              0.7      0.8
;;            /   \    /   \       ->   /   \    /   \ 
(define (sort-ptree-list L) 
  (local (
          ;; contract: tree-insert-list : treenode list -> treenode
          ;; purpose: Einfügen aller Elemente einer Liste in einen sortieren Baum. Der Ausgabewert ist ein sortierter Baum.
          (define (tree-insert-list root L)
            (local (
                    ;; contract: comp-ptree-probability : ptree-node ptree-node -> boolean
                    ;; purpose: Überprüfung, ob ein Wahrscheinlichkeitswert kleiner/gleich einem anderen Wert ist.
                    ;; example: (comp-ptree-probability
                    ;;                          (make-treenode empty (make-ptree-node 'z 1) empty)
                    ;;                          (make-treenode empty (make-ptree-node 'q 2) empty))
                    ;;           -> true
  (define (comp-ptree-probability p1 p2)
    (<= (ptree-node-p (treenode-content p1)) (ptree-node-p (treenode-content p2))))
  ;; contract: tree-insert : treenode num -> treenode
  ;; purpose: Einfügen eines neuen Elements in den sortierten Baum. Rückgabewert ist ein neuer sortierter Baum.
  (define (tree-insert root content)
    (cond 
      [(empty? root) (make-treenode empty content empty)]
      [(comp-ptree-probability content (treenode-content root)) (make-treenode (tree-insert (treenode-left root) content) (treenode-content root) (treenode-right root))]
      [else (make-treenode (treenode-left root) (treenode-content root) (tree-insert (treenode-right root) content))])))
(if (empty? L) root (tree-insert-list (tree-insert root (first L)) (rest L)))))
;; contract: 
;; purpose: 
(define (flatten-tree root)
  (if (empty? root) 
      empty
      (append (flatten-tree (treenode-left root)) (cons (treenode-content root) (flatten-tree (treenode-right root)))))))
(flatten-tree (tree-insert-list empty L))))

;;TEST
(check-expect 
 (sort-ptree-list (list ptree3 ptree2 ptree1))
 (list ptree1 ptree2 ptree3))

;; OWN Tests

(sort-ptree-list (make-subtree-list freq))

(check-expect
 (sort-ptree-list (list ptree3 ptree1 ptree2))
 (list ptree1 ptree2 ptree3))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: build-ptree : list-of-treenodes -> treenode
;;purpose: Erstellung eines Wahrscheinlichkeits-Baumes aus einer Liste
;;         von Wahrscheinlichkeitsbäumen. Im Prozess wird die Liste sortiert
;;         und die ersten beiden Elemente (niedrigste Wahrscheinlichkeiten)
;;         werden zu einem Wahrscheinlichkeitsbaum zusammengefasst. Dies
;;         geschieht rekursiv, bis ein Wahrscheinlichkeits-Baum resultiert.
;;example: 

;; fehlerhandling noch einbauen

(define (build-ptree lop) 
  (local (
          ;; contract:
          (define (ptree-loop lop)
            (local (
                    (define t1 (first lop))
                    (define t2 (first (rest lop)))
                    (define t3 (make-treenode
                                t1
                                (make-ptree-node
                                 'unused (+
                                          (ptree-node-p (treenode-content t1))
                                          (ptree-node-p (treenode-content t2))
                                          )
                                 )
                                t2))
                    )
              (cond
                ;; Rekursionsanker, bei Erreichen wird der letzte Baum gebildet
                [(empty? (rest (rest lop))) t3]
                ;; Prozess
                [else
                 (ptree-loop
                  (sort-ptree-list
                   (append
                    (list t3)
                    (rest (rest lop))
                    )))]))))
    (ptree-loop (sort-ptree-list lop))
    ))


;TEST
(check-expect 
 (build-ptree (list ptree1 ptree2 ptree3))
 (make-treenode
  ptree3
  (make-ptree-node 'unused 0.6)
  (make-treenode
   ptree1
   (make-ptree-node 'unused 0.3)
   ptree2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: ptree-contains? : symbol treenode(ptree-node) -> boolean
;;purpose: Prüfung auf Vorhandensein eines Symbols in einem Wahrscheinlichkeitsbaum
;;         mit beliebig vielen Blättern.
;;example: 

(define (ptree-contains? sym tree)
  (cond
    ;; Rekursionsanker
    [(empty? (treenode-content tree)) empty]
    ;; Fehler prüfen
    [(not (symbol? sym))    "Fehler: ungültiges Symbol"]
    [(not (treenode? tree)) "Fehler: ungültiger Baum"]
    ;; inhalte prüfen, besser noch variablen deklarieren und einen local-teil erstellen
    [(and (symbol? (ptree-node-s (treenode-content tree))) (symbol=? (ptree-node-s (treenode-content tree)) sym)) true]    ;; content
    [(and (treenode? (treenode-left tree)) (ptree-contains? sym (treenode-left tree))) true] ;; links
    [(and (treenode? (treenode-right tree)) (ptree-contains? sym (treenode-right tree))) true] ;; rechts
    [else false]            
    )
  )

;;TEST
(check-expect 
 (ptree-contains? 'c ptree3)
 true)

;;TEST
(check-expect 
 (ptree-contains? 'c (make-treenode empty (make-ptree-node 'unused 0.9)  ptree3))
 true)

;;contract: ptree-encode : symbol treenode(ptree-node) -> list-of-numbers
;;purpose: Berechnung der binären Codierung eines Symbols mithilfe eines Wahrscheinlichkeitsbaumes.
;;         Ist das Symbol im linken Ast enthalten, wird der Liste eine 0 hinzugefügt.
;;         Ist das Symbol im rechten Ast enthalten, wird der Liste eine 1 hinzugefügt.
;;example: 
(define (ptree-encode sym tree)
  (cond
    ;; Fehler
    [(empty? (treenode-content tree)) empty] ;; empty nicht als Rekursionsanker ausgeben, sondern gesonderte Variable ausgeben -> siehe 5.2.2
    [(not (symbol? sym)) "Fehler, kein Symbol."]
    [(not (treenode? tree)) "Fehler, kein Tree"]
    ;; Inhalte prüfen
    [(symbol=? (ptree-node-s (treenode-content tree)) sym) empty]
    [(ptree-contains? sym (treenode-left tree))  (append (list 0) (ptree-encode sym (treenode-left tree)))]
    [(ptree-contains? sym (treenode-right tree)) (append (list 1) (ptree-encode sym (treenode-right tree)))]
    [else empty]    
    )
  )


;;TEST
(check-expect 
 (ptree-encode 'a (make-treenode ptree1 (make-ptree-node 'unused 0.9) ptree3))
 '(0))


;;contract: ptree-encode-list : list-of-symbols treenode(ptreenode) -> list(list-of-numbers)
;;purpose: Verarbeitung einer Liste (bestehend aus Symbolen) zu einer Liste
;;         mit codierten Symbolen. Dazu wird die Funktion ptree-encode aufgerufen.
;;         Grundlage für die Codierung ist ein Wahrscheinlichkeitsbaum.
;;example: 

(define (ptree-encode-list los lot)  
  (cond
    ;; Rekursionsanker
    [(empty? los) empty]
    ;; Fehlercheck
    [(not (symbol? (first los))) "Fehler: Liste enthält nicht nur Symbole."]
    ;; Prozedur
    [else (append (list (ptree-encode (first los) lot)) (ptree-encode-list (rest los) lot))]
    )
  )

;;TEST
(check-expect
 (ptree-encode-list '(g d i space i s t space t o l l) (build-ptree (make-subtree-list freq)))
 (list '(1 0 0 0 1 1) '(1 1 0 1 0) '(0 1 1 0) '(1 1 1) '(0 1 1 0) '(0 0 1 1) '(1 1 0 0) '(1 1 1) '(1 1 0 0) '(1 0 0 1) '(1 0 1 1 0) '(1 0 1 1 0)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;TASK 5.2.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;

;; Abschliessender Test zur Zeichen-Codierung
"informatik macht spass"
(ptree-encode-list '(i n f o r m a t i k space m a c h t space s p a s s) (build-ptree (make-subtree-list freq)))



