;;define PI
(define p 3.14)

;;Contract: get-circle-area: number -> number
;;Purpose: Given the radius of a circle r, the procedure returns that circle's area.
;;Example: (get-circle-area 3) should produce 28.26
(define (get-circle-area r) 
(* r r p))
;; Test
(get-circle-area 3.5)
;; should be 
38.465
;; Test
(get-circle-area  1)
;; should be 
3.14

;;Contract: get-square-area: number -> number
;;Purpose: Given the edge length of a square a, the procedure returns that square's area.
;;Example: (get-square-area 3) should produce 9
(define (get-square-area a) 
(* a a))
;; Test
(get-square-area 3.5)
;; should be 
12.25
;; Test
(get-square-area  1)
;; should be 
1

;;Contract: cut-squares: number number -> number
;;Purpose: Given two squares, the procedure determines the remaining area when cutting the smaller from the larger.
;;Example: (cut-squares 5 3) should produce 16
(define (cut-squares a1 a2) 
(if (< a1 a2) (- (get-square-area a2) (get-square-area a1)) (- (get-square-area a1) (get-square-area a2))))
;; Test
(cut-squares 3 7)
;; should be 
40
;; Test
(cut-squares 6 2)
;; should be 
32

;;Contract: cut-circles: number number -> number
;;Purpose: Given two circles, the procedure determines the remaining area when cutting the smaller from the larger.
;;Example: (cut-circles 5 3) should produce 50.24
(define (cut-circles r1 r2) 
(if (< r1 r2) (- (get-circle-area r2) (get-circle-area r1)) (- (get-circle-area r1) (get-circle-area r2))))
;; Test
(cut-circles 2 6)
;; should be 
100.48
;; Test
(cut-circles 7 3)
;; should be 
125.6

;;-------------- Alternative Solution with structs ------------------------

(define-struct circle (r))
(define-struct square (a))

;;Contract: get-area: circle-or-square -> number
;;Purpose: Given a circle or a square, the procedure returns its area.
;;Example: (get-area (make-circle 3)) should produce 28.26
(define (get-area object)
  (cond
    [(circle? object) (* (circle-r object) (circle-r object) p)]
    [(square? object) (* (square-a object) (square-a object))]
    )
  )

;; Test
(get-area (make-square 3.5))
;; should be 
12.25
;; Test
(get-area  (make-square 1))
;; should be 
1
;; Test
(get-area  (make-circle 1))
;; should be 
3.14

;;Contract: cut: circle-or-square circle-or-square -> number-or-'erroneousInput
;;Purpose: Given two circles or two squares, the procedure determines the remaining area when cutting the smaller from the larger.
;;         If the two given objects are not of the same type 'erroneousInput is returned
;;Example: (cut (make-circle 5) (make-circle 3)) should produce 50.24
(define (cut object1 object2)
    ;;test whether both objects are circles or squares
    (if(or (and (circle? object1) (circle? object2) )  (and (square? object1) (square? object2) ))
         (if (< (get-area object1) (get-area object2)) 
             (- (get-area object2) (get-area object1)) (- (get-area object1) (get-area object2)))
     'erroneousInput))
;; Test
(cut (make-square 3) (make-square 7))
;; should be 
40
;; Test
(cut (make-circle 7) (make-circle 3))
;; should be 
125.6
;; Test
(cut (make-circle 3) (make-square 5))
;;should be 
'erroneousInput


    





