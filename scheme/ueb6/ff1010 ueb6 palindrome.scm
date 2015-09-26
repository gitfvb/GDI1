;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |ff1010 ueb6 palindrome|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

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
;;TASK 7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;--------------------------------------
;; Contract: palindrome: (listof x) -> (listof x)
;; Purpose:  to build a list which transforms the given
;;           list into a palindrome list..
;; Examples 1.) (palindrome (list 'a 'b 'c)) 
;;                 should produce: (list 'a 'b 'c 'b 'a)
;;          2.) (palindrome (list 1 2 3 4))
;;                 should produce: (list 1 2 3 4 3 2 1)
;;--------------------------------------

(define (palindrome alox)
  (cond
    [(empty? (rest alox)) alox]
    [else (append alox (reverse alox))]
    )
  )

;;******************
;; Tests
;;******************

(check-expect
 (palindrome (list 'a 'b 'c)) 
 (list 'a 'b 'c 'c 'b 'a)
 )

(check-expect
 (palindrome (list 1 2 3 4))
 (list 1 2 3 4 4 3 2 1)
 )