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
;; Contract: vec-mult: list-of-num list-of-num -> num
;; Purpose:  computes the inner product of two vectors
;; Example:  (vec-mult '(1 0 1) '(1 0 1)) -> 2
(define (vec-mult vector1 vector2) 
  (cond
    ;; list-of-num empty? anchor reached, do not recurse further
    ;; inner product of two empty vectors is 0
    [(empty? vector1) 0]
    ;; else add product of first components to inner product of remaining components
    [else (+ (* (first vector1) (first vector2)) (vec-mult (rest vector1) (rest vector2)))]))
;; Test
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
(define-struct document (name content))

;; first document
(define doc1
  (make-document 'doc1 '(mouse keyboard screen)))

;; second document
(define doc2
  (make-document 'doc2 '(pascal java scheme)))

;----------------------------------
;   Aufgabe / Task 5.3
;----------------------------------
;; Contract: index: list-of-documents -> list-of-symbols 
;; Purpose:  builds a list of all symbols contained in the content 
;;           of the documents contained in list-of-documents without 
;;           duplicates
;; Example:  (list-of-documents 
;;             (list 
;;               (make-document 'doc1 '(a b))
;;               (make-document 'doc2 '(b c)))) -> '(a b c)
(define (index list-of-documents)
  (cond
    ;; list-of-documents empty? anchor reached, do not recurse further
    ;; empty list does not contain any documents and therefore no
    ;; words return empty list as index
    [(empty? list-of-documents) empty]
    ;; else, append content of first document from list
    ;; to the index of the rest of documents AND REMOVE DUPLICATES
    [else (remove-duplicates 
           (append
            (document-content (first list-of-documents))
            (index (rest list-of-documents))))]))
;; Test:
(check-expect 
 (index (list (make-document 'doc1 '(a b)) (make-document 'doc2 '(b c))))
 '(a b c))

;; index of the two documents doc1 and doc2
(define myindex
  (index (list doc1 doc2)))


;----------------------------------
;   Aufgabe / Task 5.4
;----------------------------------
;; Contract: word-vector: document-or-los los -> los
;; Purpose:  compute a word-vector for document-or-los 
;;           using los as index. If the first argument
;;           is a document, the document contents are used 
;;           else the list of symbols is used to check 
;;           whether a word from the index occurs.
;; Example:  (word-vector '(a c e) '(a b c d e)) -> '(1 0 1 0 1)
(define (word-vector document-or-query index)
  (cond
    ;; index empty? anchor reached, 
    ;; do not recurse further and return empty word vector
    [(empty? index) empty]
    ;; first argument is a document, 
    ;; call recursively with document contents
    [(document? document-or-query) 
     (word-vector (document-content document-or-query) index)]
    ;; now first argument is not a document and thus a list of symbols
    ;; first word from the index is contained -> add 1 
    ;; to the beginning of word vector for remaining index
    [(member? document-or-query (first index))
     (cons 
      1
      (word-vector document-or-query (rest index)))]
    ;; first word from the index is not contained -> add 0
    ;; to the beginning of word vector for remaining index
    [else (cons
           0
           (word-vector document-or-query (rest index)))]))

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
(define-struct result (name score))

;; Contract: compare: los document los -> result
;; Purpose:  computes the similarity for document and query (los)
;;           and returns a result 
;; Example:  (query '(java mouse scheme) doc1)
;;             -> (make-result 'doc1 0.111..) 
(define (compare q document index)
  (make-result 
   (document-name document)
   (cosine-similarity 
    (word-vector q index) 
    (word-vector (document-content document) index))))

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
;; Contract: query_help los list-of-documents los -> list-of-results
;; Purpose:  computes the similarity for each document in the
;            list-of-documents with the list-of-symbols using los as index
;;           returns them as a list of results 
;; Example:  (query_help '(java mouse scheme) (list doc1 doc2) (index doc1 doc2)) ->
;;               (list 
;;                 (make-result 'doc1 0.111..) 
;;                 (make-result 'doc2 0.333...))
(define (query_help q list-of-documents idx) 
  (if (empty? list-of-documents)
      empty
      (cons (compare q (first list-of-documents) idx) (query_help q (rest list-of-documents) idx))))

;; Test 1
(define query-help-test1 (query_help '(java mouse scheme) (list doc1 doc2) (index (list doc1 doc2))))
(check-expect (cons? query-help-test1) true)
(check-expect (result? (first query-help-test1)) true)
(check-expect (result? (first (rest query-help-test1))) true)
(check-expect (result-name (first query-help-test1)) 'doc1)
(check-expect (result-name (first (rest query-help-test1))) 'doc2)
(check-within (result-score (first query-help-test1)) 0.333 0.001)
(check-within (result-score (first (rest query-help-test1))) 0.666 0.001)

;; Test 2
(define query-help-test2 (query_help '(keyboard mouse scheme) (list doc1 doc2) (index (list doc1 doc2))))
(check-expect (cons? query-help-test2) true)
(check-expect (result? (first query-help-test2)) true)
(check-expect (result? (first (rest query-help-test2))) true)
(check-expect (result-name (first query-help-test2)) 'doc1)
(check-expect (result-name (first (rest query-help-test2))) 'doc2)
(check-within (result-score (first query-help-test2)) 0.666 0.001)
(check-within (result-score (first (rest query-help-test2))) 0.333 0.001)


;; Contract: query: los list-of-documents -> list-of-results
;; Purpose:  computes the similarity for each document in the
;            list-of-documents with the list-of-symbols and
;;           returns them as a list of results 
;; Example:  (query '(java mouse scheme) (list doc1 doc2)) ->
;;               (list 
;;                 (make-result 'doc1 0.111..) 
;;                 (make-result 'doc2 0.333...))
(define (query q list-of-documents) 
  (query_help q list-of-documents (index list-of-documents)))

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

