;;the database
;; struct for storing student records
(define-struct student (name matrikel))

;; some example students
(define melanie (make-student 'melanie 1234567))
(define daniel (make-student 'daniel 2234567))
(define guido (make-student 'guido 3234567))
(define gina (make-student 'gina 4234567))

(define student-table (list melanie daniel guido gina))

;;
;;
;;
(define (make-where f) ... )

;;
;;
;;
(define (make-select f) ... )

;;
;;
;;
(define (query select where table) ... )


(define select-name (make-select ...))
(define select-name-matrikel (make-select ...))
(define select-matrikel-name (make-select ...))

;;Test
(select-name
   (list (make-student 'daniel 1) (make-student 'melanie 5)))
;;should be
(list '(daniel) '(melanie))
   
;;Test
(select-name-matrikel
   (list (make-student 'daniel 1) (make-student 'melanie 5)))
;;should be
(list '(daniel 1) '(melanie 5))

;;Test
(select-matrikel-name
   (list (make-student 'daniel 1) (make-student 'melanie 5)))
;;should be
(list '(1 daniel) '(5 melanie))
