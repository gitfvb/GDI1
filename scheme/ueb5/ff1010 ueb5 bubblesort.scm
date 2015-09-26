;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |ff1010 ueb5 bubblesort|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;==========================================================
;; Übungsgruppe GDI 1 bei Florian Reith
;; ------------------------------------
;; 
;; WS 2008/2009
;; Florian Friedrichs
;; Übung 5
;;
;;==========================================================


;;==========================================================
;; Task 6.1
;;==========================================================

;; Frage:
;; Wann ist ein BubbleSort-Durchlauf für eine Liste trivial
;; und wie sieht das Ergebnis in diesen trivialen Fällen aus?

;; Antwort:
;; Ein gesamter BubbleSort-Durchlauf ist beendet, sobald jedes
;; Element einer Liste abgearbeitet und in einer sortierten
;; Liste wiederzufinden ist. 


;;==========================================================
;; Task 6.2
;;==========================================================


;;--------------------------------------
;; Contract: bubblesort-run :: alon -> alon
;; Purpose:  takes a list of numbers and switches two adjacent numbers if the left one is smaller than the right one
;;           i.e. one iteration of the bubblesort algorithm 
;; Example:  (bubblesort-run '(4 2 11 1)) -> (2 4 1 11)
;; alon is the list to sort (a_0 a_1 .... a_n)
;;--------------------------------------

(define (bubblesort-run alon)
  (cond
    ;;trivial:
    [(empty? (rest alon)) alon]
    ;;complex solution 
    [else (local (
                  (define ai (first alon)) ;; erstes Element der Liste
                  (define ai+1 (second alon)) ;; zweites Element der Liste
                  (define s (if (<= ai ai+1) ai ai+1)) ;; smaller
                  (define l (if (>= ai ai+1) ai ai+1)) ;; larger
                  (define newlist (cons l (rest (rest alon))))  ;; neue Liste mit den sortierten Elementen
                  )
            ;; recurse and combine solutions            
            (cons s (bubblesort-run newlist)))]))

;; Tests

(check-expect
 (bubblesort-run '(4 2 11 1))
 '(2 4 1 11))

(check-expect
 (bubblesort-run '(1 2 1 1))
 '(1 1 1 2))

(check-expect
 (bubblesort-run '(1 3 2 4 2))
 '(1 2 3 2 4))




;;==========================================================
;; Task 6.3
;;==========================================================


;;--------------------------------------
;; Contract: last: list-of-numbers -> number
;; Purpose:  Returns the last element of a list
;; Example:  (last '(4 2 11 1)) -> 1
;;--------------------------------------

(define (last alon)
  (first (reverse alon)))

;; Test

(check-expect
 (last '(1 2 3 4))
 4)

(check-expect
 (last '(4 2 5 1))
 1)



;;--------------------------------------
;; Contract: head: list-of-numbers -> list-of-numbers
;; Purpose:  Takes a list and resturns the same list without the last element
;; Example:  (head '(4 2 11 1)) -> '(4 2 11)
;;--------------------------------------

(define (head alon)
  (reverse (rest (reverse alon))))

;; Test

(check-expect
 (head '(1 2 3 4))
 '(1 2 3))

(check-expect
 (head '(4 2 5 1))
 '(4 2 5))


;;--------------------------------------
;; Contract: bubblesort :: alon -> alon
;; Purpose:  the main procedure for calling the bubbelsort algorithm
;;           takes a list of numbers and returns the same list in sorted order
;; Example:  (4 2 11 1) -> (1 2 4 11)
;;--------------------------------------

(define (bubblesort alon)
  (cond
    [(empty? (rest alon)) alon] ;; Rekursionsanker
    [else (local (
                  (define sorted-list (bubblesort-run alon)) ;; Sortieren der Liste
                  (define largest-element (last sorted-list)) ;; Abschneiden des letzten Elementes
                  (define newlist (head sorted-list)) ;; neue Liste ohne das letzte Element
                  )
             (append (bubblesort newlist) (list largest-element)) ;; rekursiver Aufruf zur weiteren Sortierung
            )]
    )
  )


;; Tests

(check-expect
(bubblesort '(11 7 2 5 12))
'(2 5 7 11 12))

(check-expect
(bubblesort '(1 2 1 1))
'(1 1 1 2))




