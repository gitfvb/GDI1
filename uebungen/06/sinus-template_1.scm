;; Purpose: calculate sinus x using the approximation for small numbers
;; Example: (sin-approx 3.14) should be close to 0

(define (sin-approx angle)
 ...)
;;Test
(sin-approx 1.2)
;;should be 
0.93218229417886703406711722434709627405353802620137...

;;Test
(sin-approx 3.14)
;;should be 
0.0008056774674224761882465...