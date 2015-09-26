;; Contract: 
;; Purpose:  takes a list of numbers and switches two adjacent numbers if the left one is smaller than the right one
;;           i.e. one iteration of the bubblesort algorithm 
;; Example:  (bubblesort-run '(4 2 11 1)) -> (2 4 1 11)
;; alon is the list to sort (a_0 a_1 .... a_n)
(define (bubblesort-run alon)
  (cond
    ;;trivial:
    [(... trivial condition ...) (... trivial result ....)]
    ;;complex solution 
    [else (local (
      (define ai (...))
      (define ai+1 (...)) 
      (define s (...))
      (define l (...))
      (define newlist (...)))
      ;; recurse and combine solutions            
      ( .... ))]))
      
                  
(check-expect
 (bubblesort-run '(4 2 11 1))
 '(2 4 1 11))

(check-expect
 (bubblesort-run '(1 2 1 1))
 '(1 1 1 2))



;; Contract: last: list-of-numbers -> number
;; Purpose:  Returns the last element of a list
;; Example:  (last '(4 2 11 1)) -> 1
(define (last alon)
  (first (reverse alon)))

(check-expect
 (last '(1 2 3 4))
 4)


;; Contract: head: list-of-numbers -> list-of-numbers
;; Purpose:  Takes a list and resturns the same list without the last element
;; Example:  (head '(4 2 11 1)) -> '(4 2 11)
(define (head alon)
  (reverse (rest (reverse alon))))

(check-expect
 (head '(1 2 3 4))
 '(1 2 3))

;; Contract: 
;; Purpose:  the main procedure for calling the bubbelsort algorithm
;;           takes a list of numbers and returns the same list in sorted order
;; Example:  (4 2 11 1) -> (1 2 4 11)
(define (bubblesort alon)
  ...)

(check-expect
 (bubblesort '(11 7 2 5 12))
 '(2 5 7 11 12))

(check-expect
 (bubblesort '(1 2 1 1))
 '(1 1 1 2))


                 

