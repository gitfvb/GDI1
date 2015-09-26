;;initializes the turtle-screen
(turtles)

 ;;example usage of the turtle
(list
 (draw 50)
 (turn 45)
 (draw 150)
 (turn -45)
 (draw 50)) 


(define ALPHA 30)
(define BETA (- 90 ALPHA))

;; approximations for the length of the cathetus,
;; consumes the length of the hypothenusis
;; get-b: num -> num
;; get-a: num -> num
(define (get-b c)
  (* c (sin (* (/ ALPHA 180) 3.14))))
   
   
(define (get-a c)
  (* c (sin (* (/ BETA 180) 3.14))))

;; purpose: paints a triangle with the given base length x and given angle ALPHA
;; and returns the turtle to its starting position
;; contract: triangle: num -> does not matter
(define (paintTriangle a) 
  (list
   (draw a)
   (turn (+ 90 ALPHA))
   (draw (get-b a) )
   (turn 90)
   (draw (get-a a))
   (turn (- 180 ALPHA))))



(define (pythagoras-step x)
  ;;insert sth. smart here
  )


;; recursively paints a pythagoras tree with given base width x
;; pythagoras-tree: num-> does not matter
(define (pythagoras-tree a)
  ;;insert sth. smart here
  )

;;TEST
(pythagoras-tree 40)

