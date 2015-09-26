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
