;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname db_template_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

;;================================================
;; Übungsgruppe GDI 1 bei Florian Reith
;; ------------------------------------
;; 
;; WS 2008/2009
;; Florian Friedrichs
;; Übung 4
;;
;;================================================

;;the database
;; struct for storing student records
(define-struct student (name matrikel))

;;******************
;; some example students
;;******************

(define melanie (make-student 'melanie 1234567))
(define daniel (make-student 'daniel 2234567))
(define guido (make-student 'guido 3234567))
(define gina (make-student 'gina 4234567))

(define student-table (list melanie daniel guido gina))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 6.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;--------------------------------------
;; contract: make-where :: (X -> boolean) -> (list-of-X -> list-of-X)
;; purpose: Die Funktion konsumiert eine Funktion. Zurückgeliefert
;;          wird eine Filter-Funktion, die auf eine Liste angewandt
;;          werden kann.
;; example: (define where-smaller-5 (make-where (lambda (x) (< x 5))))
;;          => erzeugt eine Funktion, die Werte <5 aus einer Liste
;;          von Zahlen aussortiert.
;;--------------------------------------

(define (make-where f)
  (lambda (x) (filter f x))
  )


;;******************
;; Given Tests
;;******************

;; contract: where-larger-4 :: list-of-numbers -> list-of-numbers
;; purpose: Ausgabe aller Zahlenwerte einer Liste, die größer 4
;;          sind. Dazu wird die Funktion "make-where" genutzt.
(define where-larger-4 (make-where (lambda (x) (> x 4))))

(check-expect
 (where-larger-4 '(1 2 3 4 5 6))
 (list 5 6))


;;******************
;; Own tests
;;******************

;; contract: where-smaller-5 :: list-of-numbers -> list-of-numbers
;; purpose: Ausgabe aller Zahlenwerte einer unsortierten Liste,
;;          die kleiner 5 sind. Dazu wird die Funktion "make-where"
;;          genutzt.
(define where-smaller-5 (make-where (lambda (x) (< x 5))))

(check-expect
 (where-smaller-5 '(-1 -2 1 2 5 6 100 -30))
 (list -1 -2 1 2 -30))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 6.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;--------------------------------------
;; contract: make-select :: (X -> list) -> (list-of-X -> list-of-X)
;; purpose: Konsumierung einer Funktion, die eine Elemente einer
;;          Liste selektieren kann. Der Rückgabewert entspricht
;;          einer Liste mit den selektierten Elementen der
;;          jeweiligen Struktur.
;; example: (define select-matrikel (make-select (lambda (x) (list (student-matrikel x)))))
;;          => Selektion der Matrikel-Nummern aus einer Liste von Studenten (mit Struktur "student")
;;--------------------------------------

(define (make-select f)
  (lambda (x) (map f x))
  )


;;******************
;; exemplary functions for make-select
;;******************

;; contract: select-name :: list-of-student -> list-of-student
;; purpose: Selektion des Elements "name" aus der Struktur "student"
;;          für die übergebene Liste von Studenten.
(define select-name (make-select (lambda (x) (list (student-name x)))))

;; contract: select-name-matrikel :: list-of-student -> list-of-student
;; purpose: Selektion der Elemente "name" und "matrikel" aus der Struktur "student"
;;          für die übergebene Liste von Studenten.
(define select-name-matrikel (make-select (lambda (x) (list (student-name x) (student-matrikel x)))))

;; contract: select-matrikel-name :: list-of-student -> list-of-student
;; purpose: Selektion der Elemente "matrikel" und "name" aus der Struktur "student"
;;          für die übergebene Liste von Studenten.
(define select-matrikel-name (make-select (lambda (x) (list (student-matrikel x) (student-name x)))))

;; contract: select-matrikel :: list-of-student -> list-of-student
;; purpose: Selektion des Elements "matrikel" aus der Struktur "student"
;;          für die übergebene Liste von Studenten.
(define select-matrikel (make-select (lambda (x) (list (student-matrikel x)))))


;;******************
;; Given tests
;;******************

(check-expect
 (select-name
  (list (make-student 'daniel 1) (make-student 'melanie 5)))
 (list '(daniel) '(melanie)))

(check-expect
 (select-name-matrikel
  (list (make-student 'daniel 1) (make-student 'melanie 5)))
 (list '(daniel 1) '(melanie 5)))

(check-expect
 (select-matrikel-name
  (list (make-student 'daniel 1) (make-student 'melanie 5)))
 (list '(1 daniel) '(5 melanie)))


;;******************
;; Own tests
;;******************

(check-expect
 (select-name student-table)
 (list (list 'melanie) (list 'daniel) (list 'guido) (list 'gina)))

(check-expect
 (select-name-matrikel student-table)
 (list (list 'melanie 1234567) (list 'daniel 2234567) (list 'guido 3234567) (list 'gina 4234567))) 

(check-expect
 (select-matrikel-name student-table)
 (list (list 1234567 'melanie) (list 2234567 'daniel) (list 3234567 'guido) (list 4234567 'gina)))







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 6.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;-------------------------------------- 
;; contract: query :: make-select make-where list-of-X -> list-of-X  
;; purpose: Anzeige von Elementen einer Liste, die einem Filter entsprechen.
;;          Zusätzlich lassen sich aus diesen Elementen einzelne Elemente
;;          selektieren, sofern die oberen Elemente eine Struktur haben.
;; example: (define where-matrikel-smaller-2234567 (make-where (lambda (los) (< (student-matrikel los) 2234567))))
;;          -> Selektion und Ausgabe von Studenten-Namen, deren Matrikel-Nummern kleiner 2234567 sind
;;--------------------------------------

(define (query select where table)
  (select (where table))
  )


;;******************
;; exemplary functions for make-select
;;******************

;; contract: where-matrikel-larger-4 :: list-of-student -> list-of-student
;; purpose: Auswahl aller Studenten aus einer Liste, deren Matrikel-Nummer größer 4 ist.
(define where-matrikel-larger-4 (make-where (lambda (los) (> (student-matrikel los) 4))))

;; contract: where-matrikel-smaller-2234567 :: list-of-student -> list-of-student
;; purpose: Auswahl aller Studenten aus einer Liste, deren Matrikel-Nummer kleiner 2234567 ist.
(define where-matrikel-smaller-2234567 (make-where (lambda (los) (< (student-matrikel los) 2234567))))


;;******************
;; given tests
;;******************

(check-expect
 (query select-name where-matrikel-larger-4
        (list (make-student 'daniel 1) (make-student 'melanie 5)))
 (list '(melanie)))


;;******************
;; own tests
;;******************

(check-expect
 (query select-name where-matrikel-smaller-2234567 student-table)
 (list (list 'melanie)))        
