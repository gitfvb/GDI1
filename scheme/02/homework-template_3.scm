;; Contract: member?: los symbol -> boolean 
;; Purpose:  computes if symbol is member of los
;; Example:  (member? '(a b) 'b) -> true
(define (member? los symbol)
  (cond 
    ;; list empty? anchor reached, 
    ;; do not recurse further
    ;; symbol not contained in empty list, return false
    [(empty? los) false]
    ;; else, list contains at least one element 
    ;; return true if the first element is equal 
    ;; to searched symbol
    [(symbol=? (first los) symbol) true]
    ;; first element is not the searched symbol, 
    ;; check if searched symbol is member of
    ;; the rest of list by the recursive call
    [else (member? (rest los) symbol)]))
;; Test
(check-expect (member? '(a b c) 'c) true)

;; Contract: remove-duplicates los -> los 
;; Purpose:  removes all duplicates from a list of symbols
;; Example:  (remove-duplicates '(a a b)) -> '(a b)
(define (remove-duplicates list-of-symbols )
  (cond 
    ;; list empty? anchor reached,
    ;; do not recurse further
    ;; empty list does not contain duplicates
    ;; and can be returned
    [(empty? list-of-symbols) list-of-symbols]
    ;; first element is a duplicate 
    ;; (is a member of the rest of the list)
    [(member? (rest list-of-symbols) (first list-of-symbols))
     ;; so return rest of the list with remaining
     ;; duplicates removed
     (remove-duplicates (rest list-of-symbols))]
    ;; first element is not a duplicate. 
    ;; Remove duplicates from the rest of the list
    ;; and add first element at the beginning
    [else (cons 
           (first list-of-symbols) 
           (remove-duplicates (rest list-of-symbols)))]))
;; Test
(check-expect (remove-duplicates '(a a b)) '(a b))

;----------------------------------
;   Aufgabe / Task 5.1
;----------------------------------
;; Contract: 
;; Purpose:  
;; Example:  



(check-expect (vec-mult '(1 0) '(0 1)) 0)

;; Contract: cosine-similarity list-of-num list-of-num -> num
;; Purpose:  computes the cosine of the two vectors
;; Example:  (cosine-similarity '(1 0) '(0 1)) -> 0
(define (cosine-similarity vector1 vector2) 
  (/ 
   (vec-mult vector1 vector2)
   (* 
    (sqrt (vec-mult vector1 vector1))
    (sqrt (vec-mult vector2 vector2)))))
;; Test
(check-expect (cosine-similarity '(1 0) '(0 1)) 0)
(check-within (cosine-similarity '(1 1) '(1 1)) 1 0.001)

;----------------------------------
;   Aufgabe / Task 5.2
;----------------------------------
;; struct for storing documents

;----------------------------------
;   Aufgabe / Task 5.3
;----------------------------------
;; Contract: 
;; Purpose:  
;; Example:  


;; Test
(check-expect 
 (index (list (make-document 'doc1 '(a b)) (make-document 'doc2 '(b c))))
 '(a b c))



;; index of the two documents doc1 and doc2
(define myindex
  (index (list doc1 doc2)))


;----------------------------------
;   Aufgabe / Task 5.4
;----------------------------------
;; Contract: 
;; Purpose:  
;; Example:  

;; Test
(check-expect 
 (word-vector '(a c e) '(a b c d e))
 (list 1 0 1 0 1))

(check-expect 
 (word-vector '(java mouse algol) myindex)
 (list 1 0 0 0 1 0))

(check-expect 
 (word-vector doc1 myindex)
 (list 1 1 1 0 0 0))



;----------------------------------
;   Aufgabe / Task 5.5
;----------------------------------
;;struct to store results, document names with a similarity score


;; Contract: 
;; Purpose:  
;; Example:  

;; Test 1
(check-expect 
 (result? (compare (document-content doc1) doc1 myindex))
 true)
(check-expect 
 (result-name (compare (document-content doc1) doc1 myindex))
 'doc1)
(check-within 
 (result-score (compare (document-content doc1) doc1 myindex))
 1
 0.01)

;; Test 2
(check-expect 
 (result? (compare '(java mouse) doc1 myindex))
 true)
(check-expect 
 (result-name (compare '(java mouse) doc1 myindex))
 'doc1)
(check-within 
 (result-score (compare '(java keyboard mouse) doc1 myindex))
 0.666
 0.001)



;----------------------------------
;   Aufgabe / Task 5.6
;----------------------------------
;; Contract: 
;; Purpose:  
;; Example:  


;; Test
(define query-test1 (query '(java mouse scheme) (list doc1 doc2)))
(check-expect (cons? query-test1) true)
(check-expect (result? (first query-test1)) true)
(check-expect (result? (first (rest query-test1))) true)
(check-expect (result-name (first query-test1)) 'doc1)
(check-expect (result-name (first (rest query-test1))) 'doc2)
(check-within (result-score (first query-test1)) 0.333 0.001)
(check-within (result-score (first (rest query-test1))) 0.666 0.001)

;; Test
(define query-test2 (query '(java pascal scheme) (list doc1 doc2)))
(check-expect (cons? query-test2) true)
(check-expect (result? (first query-test2)) true)
(check-expect (result? (first (rest query-test2))) true)
(check-expect (result-name (first query-test2)) 'doc1)
(check-expect (result-name (first (rest query-test2))) 'doc2)
(check-within (result-score (first query-test2)) 0.0 0.001)
(check-within (result-score (first (rest query-test2))) 1 0.001)

