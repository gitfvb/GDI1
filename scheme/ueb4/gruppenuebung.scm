;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname gruppenuebung) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;1
;f: number -> number"
;2
; f: number -> (number -> number)
;3-5
(define (add2 x) (+ x 2))
(define (add3 x) (+ x 3))
(define (add4 x) (+ x 4))