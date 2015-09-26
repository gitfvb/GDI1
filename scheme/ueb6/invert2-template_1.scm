;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname invert2-template) (read-case-sensitive #t) (teachpacks ((lib "turtles.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "turtles.ss" "installed-teachpacks")))))
;; invert2 : (listof X) -> (listof X)
;; construct the reverse of list lst
;; example: (invert2 (list 'A 'B 'C)) should return (list 'C 'B 'A)
(define (invert2 lst)
    ;; rcons : (listof X) X -> (listof X)
    ;; appends el to the end of list lst.
    ;; example: (rcons (list 'A 'B) 'C) should be (list 'A 'B 'C)
	(local (
	  (define (rcons lst el)
             (...) ))
     (...) ))