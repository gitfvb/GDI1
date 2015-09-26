;;Contract: get-m: number number number number -> number
;;Purpose: Given X1 Y1 X2 Y2, the procedure calculates the gradient of a line through the points (X1 Y1) and (X2 Y2)
;;Example: (get-m 0 0 2 3) should produce 1.5
(define (get-m x1 y1 x2 y2) 
 (/ (- y2 y1) (- x2 x1)))
;; Test
(get-m 1 1 3 7)
;; should be 
3
;; Test
(get-m 0 0 3.5 -3.5)
;; should be 
-1

;;Contract: get-n: number number number number -> number
;;Purpose: Given X1 Y1 X2 Y2, the procedure calculates the Y-axis intercept of a line through the points (X1 Y1) and (X2 Y2)
;;Example: (get-n 0 0 2 3) should produce 0
(define (get-n x1 y1 x2 y2) 
 (- y1 (* (get-m x1 y1 x2 y2) x1)))
;; Test
(get-n 1 1 3 7)
;; should be 
-2
;; Test
(get-n 0 0 3.5 -3.5)
;; should be 
0

;;Contract: is-parallel: number number number number number number number number -> boolean
;;Purpose: Given X1 Y1 X2 Y2 X3 Y3 X4 Y4, the procedure calculates whether the line l1 through the points (X1 Y1) and (X2 Y2) and the line l2 through the points (X3 Y3) and (X4 Y4) are parallel
;;Example: (is-parallel 0 0 2 3 0 0 3.5 -3.5) should produce false 
(define (is-parallel x1 y1 x2 y2 x3 y3 x4 y4) 
 (= (get-m x1 y1 x2 y2) (get-m  x3 y3 x4 y4)))
;; Test
(is-parallel 1 1 3 7 0 0 3.5 -3.5)
;; should be 
false
;; Test
(is-parallel 0 0 1 1 2 2 3 3)
;; should be 
true

;;Contract: get-intersection-point-x: number number number number number number number number -> number
;;Purpose: Given X1 Y1 X2 Y2 X3 Y3 X4 Y4, the procedure calculates the x-value of the intersection point of the line l1 through the points (X1 Y1) and (X2 Y2) and the line l2 through the points (X3 Y3) and (X4 Y4). If the lines are parallel an error occurs. 
;;Example: (get-intersection-point-x 0 0 2 3 0 0 3.5 -3.5) should produce 0  
(define (get-intersection-point-x x1 y1 x2 y2 x3 y3 x4 y4) 
(/ (- (get-n x3 y3 x4 y4) (get-n x1 y1 x2 y2)) (- (get-m x3 y3 x4 y4) (get-m x1 y1 x2 y2))))
;; Test
(get-intersection-point-x 1 1 3 7 0 0 3.5 -3.5)
;; should be 
0.5
;; Test
(get-intersection-point-x 0 0 1 2 2 2 3 3)
;; should be 
0

;;Contract: get-intersection-point-y: number number number number number number number number -> number
;;Purpose: Given X1 Y1 X2 Y2 X3 Y3 X4 Y4, the procedure calculates the y-value of the intersection point of the line l1 through the points (X1 Y1) and (X2 Y2) and the line l2 through the points (X3 Y3) and (X4 Y4). If the lines are parallel an error occurs. 
;;Example: (get-intersection-point-y 0 0 2 3 0 0 3.5 -3.5) should produce 0  
(define (get-intersection-point-y x1 y1 x2 y2 x3 y3 x4 y4) 
(+ (* (get-intersection-point-x x1 y1 x2 y2 x3 y3 x4 y4) (get-m x1 y1 x2 y2)) (get-n x1 y1 x2 y2)))
;; Test
(get-intersection-point-y 1 1 3 7 0 0 3.5 -3.5)
;; should be 
-3.5
;; Test
(get-intersection-point-y 0 0 1 2 2 2 3 3)
;; should be 
0


