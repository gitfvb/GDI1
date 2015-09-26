;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |ff1010 ueb5 pythagoras|) (read-case-sensitive #t) (teachpacks ((lib "turtles.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "turtles.ss" "installed-teachpacks")))))
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
;; Task 7.1
;;==========================================================

;;initializes the turtle-screen
(turtles)

;;example usage of the turtle
;(list
; (draw 50)
; (turn 45)
; (draw 150)
; (turn -45)
; (draw 50)
; (turn -270)
; (move 100)) 





;;==========================================================
;; Task 7.2.1
;;==========================================================

;; definitions
(define ALPHA 30)
(define BETA (- 90 ALPHA))


;;--------------------------------------
;; contracts: get-b: num -> num
;;            get-a: num -> num
;; purpose: approximations for the length of the cathetus,
;;          consumes the length of the hypothenusis
;;--------------------------------------

(define (get-b c)
  (* c (sin (* (/ ALPHA 180) 3.14))))


(define (get-a c)
  (* c (sin (* (/ BETA 180) 3.14))))


;;--------------------------------------
;; contract: paintTriangle :: num -> does not matter
;; purpose: paints a triangle with the given base length x and given angle ALPHA
;;          and returns the turtle to its starting position
;;--------------------------------------

(define (paintTriangle a) 
  (list
   (draw a)
   (turn (+ 90 ALPHA))
   (draw (get-b a) )
   (turn 90)
   (draw (get-a a))
   (turn (- 180 ALPHA))))


;;--------------------------------------
;; contract: paintObj :: num num -> does not matter
;; purpose: paints an object with n corners and
;;          side-length x.
;; example: (paintObj 3 10) -> an equilateral triangle with side-length 10
;;          (paintObj 4 20) -> a square with side-length 20
;;--------------------------------------

(define (paintObj n x)
  (local (
          (define angle (/ 360 n))
          (define (paintPart i)
            (cond
              [(= i n) empty]
              [else (list
                     (draw x)
                     (turn angle)
                     (paintPart (+ i 1))
                     )]
              )))
    (paintPart 0)
    )
  )

;; Tests

;(paintObj 4 50)
;(paintObj 10 20)

;;--------------------------------------
;; contract: paintSquare :: num -> does not matter
;; purpose: paints a square with side-length a
;; example: (paintSquare 50) -> paints square with side-length 50
;;--------------------------------------

(define (paintSquare a) (paintObj 4 a))

;; Test

;(paintSquare 50)
;(paintSquare 20)


;;--------------------------------------
;; contract: pythagoras-step :: num -> does not matter
;; purpose: paints a square and a triangle above
;; example: (pythagoras-step 30) -> a square with side-length 30 and a triangle
;;--------------------------------------

(define (pythagoras-step x)
  (list
   (paintSquare x) ;; paint square
   (turn 90) (move x) (turn 270) ;; go to right position for a triangle
   (paintTriangle x) ;; paint triangle
   )
  )

;; Test

;(pythagoras-step 50)
;(pythagoras-step 20)



;;==========================================================
;; Task 7.2.2
;;==========================================================

;; Frage:
;; Überlegen Sie sich ein geeignetes Abbruchkriterium, das bestimmt
;; bis zu welcher Stufe ein Pythagoras-Baum gekennzeichnet wird.

;; Antwort
;; Ein geeignetes Abbruchkriterium ist die nicht mehr darstellbare
;  Seitenlänge a - in diesem Fall a<1 Pixel - , die rekursiv errechnet wird.

(define MAX-WIDTH 1) ;; max width for the elements

;;==========================================================
;; Task 7.2.3
;;==========================================================

;;--------------------------------------
;; contract: pythagoras-tree: num-> does not matter
;; purpose: recursively paints a pythagoras tree with given base width x
;; example: (pythagoras-tree 50) -> a pythagoras-tree, beginning with side-length 50
;;--------------------------------------

(define (pythagoras-tree a)
  (cond
    [(<= a MAX-WIDTH) empty] ;; trivial
    [else 
     (list
      (pythagoras-step a)          ;; paint object
      (turn ALPHA)                 ;; move to left leaf
      (pythagoras-tree (get-a a))  ;; recursion for left leaf
      (move (get-a a)) (turn 270)  ;; move to right leaf
      (pythagoras-tree (get-b a))  ;; recursion for right leaf
      (move (get-b a)) (turn (+ 270 BETA)) (move a) (turn 270) (move a) (turn 180) ;; go to root
      ) 
     ]
    )
  )

;; Tests

;(pythagoras-tree 100)
(pythagoras-tree 50)
