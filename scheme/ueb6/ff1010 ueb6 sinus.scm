;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |ff1010 ueb6 sinus|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

;;================================================
;; Übungsgruppe GDI 1 bei Florian Reith
;; ------------------------------------
;; 
;; WS 2008/2009
;; Florian Friedrichs
;; Übung 6
;;
;;================================================


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 8.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;******************
;; Größte Schranke für den angle-Wert von sin-approx
;;******************

(define diff 0.1)


;;--------------------------------------
;; Contract: sin-approx :: number -> number
;; Purpose: calculate sinus x using the approximation for small numbers
;; Example: (sin-approx 3.14) should be close to 0
;;--------------------------------------

(define (sin-approx angle)
  (cond
    [(<= (abs angle) diff) angle]
    [else
     (local
       (
        (define sin_x/3 (lambda (x) (sin-approx (/ x 3))))
        )
       (-
        (* 3 (sin_x/3 angle))
        (* 4 (expt (sin_x/3 angle) 3))
        )
       )
     ]
    )
  )

;;******************
;;Tests 
;;******************

(sin-approx 1.2)
;;should be 
; 0.93218229417886703406711722434709627405353802620137...

(sin-approx 3.14)
;;should be 
;0.0008056774674224761882465...



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 8.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Frage:
; Wie oft ruft sich Ihre Funktion rekursiv selbst auf, wenn Sie den Sinus von 12.15 berechnen? 
; Begründen Sie Ihre Antwort! 

; Antwort:
; Die Funktion ruft sich selbst 5 mal rekursiv auf. Der Wert 12.15 wird 5 mal durch 3 geteilt,
; was dann einen kleineren Wert als 0,1 ergibt. Wenn diese Schranke erreicht ist, wird
; der Wert in der Formel berechnet.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 8.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Frage:
; Da sin periodisch ist, gilt sin(x) = sin(x mod 2Π), x mod 2Π ist dabei der Rest, der bei 
; der Teilung durch 2Π entsteht. Jedes x kann so im ersten Schritt auf das Intervall [0, 2Π] 
; abgebildet werden, das größte x für das sin(x) also rekursiv berechnet werden muss, ist 
; x = 2Π. Was ist daher die Komplexität des Algorithmus? 

; Antwort:
; Die Komplexität ist O(n)