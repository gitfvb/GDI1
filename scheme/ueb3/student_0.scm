;; struct for storing student records
(define-struct student (name matrikel birthyear birthmonth birthday))

;; some example students
(define melanie (make-student 'melanie 1234567 1968 6 12))
(define daniel (make-student 'daniel 2234567 1982 8 5))
(define guido (make-student 'guido 3234567 1980 5 5))
(define gina (make-student 'gina 4234567 1980 5 7))


;;--------------------------------------
;;sort students by matrikel
;;--------------------------------------

;;contract: list-of-students -> list-of-students
;;purpose:  sorts a list of students by matrikel
(define (sort-student-list-matrikel L) 
  (local (
          (define-struct treenode (left content right))
          ;;contract: treenode list -> treenode
          ;;purpose:  inserts all elements of list into the sorted binary tree root and returns the new sorted binary tree
          (define (tree-insert-list root L)
            (local (
                    ;;contract: student student -> boolean
                    ;;purpose:  return true if the first student's matrikel is less or equal than the second student's matrikel
                    ;;example: (comp-student-matrikel (make-student 'melanie 1234567 1968 6 12)) (make-student 'daniel 2234567 1982 8 5))) -> true
                    (define (comp-student-matrikel stud1 stud2)
                      (<= (student-matrikel stud1) (student-matrikel stud2)))
                    ;;contract: treenode num -> treenode
                    ;;purpose:  inserts content into the sorted binary tree root and returns the new sorted binary tree
                    (define (tree-insert root content)
                      (cond 
                        [(empty? root) (make-treenode empty content empty)]
                        [(comp-student-matrikel content (treenode-content root)) (make-treenode (tree-insert (treenode-left root) content) (treenode-content root) (treenode-right root))]
                        [else (make-treenode (treenode-left root) (treenode-content root) (tree-insert (treenode-right root) content))])))
              (if (empty? L) root (tree-insert-list (tree-insert root (first L)) (rest L)))))
          ;;contract: tree -> list
          ;;purpose:  outputs all elements of the tree in infix order
          ;;example: (flatten-tree empty (tree-insert-list empty '(5 6))) -> '(5 6)
          (define (flatten-tree root)
            (if (empty? root) 
                empty
                (append (flatten-tree (treenode-left root)) (cons (treenode-content root) (flatten-tree (treenode-right root)))))))
  (flatten-tree (tree-insert-list empty L))))

;;Test
(check-expect
 (sort-student-list-matrikel (list daniel gina guido melanie))
 (list melanie daniel guido gina))


;;--------------------------------------
;;sort students by age
;;--------------------------------------

;;contract: list-of-students -> list-of-students
;;purpose:  sorts a list of students by matrikel
(define (sort-student-list-age L) 
  (local (
          (define-struct treenode (left content right))
          ;;contract: treenode list -> treenode
          ;;purpose:  inserts all elements of list into the sorted binary tree root and returns the new sorted binary tree
          (define (tree-insert-list root L)
            (local (
                    ;;contract: student student -> boolean
                    ;;purpose:  return true if the first student's age is less or equal than the second student's age
                    ;;example: (comp-student-age (make-student 'melanie 1234567 1968 6 12)) (make-student 'daniel 2234567 1982 8 5))) -> false
                    (define (comp-student-age stud1 stud2)
                      (or
                          (< (student-birthyear stud1) (student-birthyear stud2))
                          (and 
                            (= (student-birthyear stud1) (student-birthyear stud2))
                            (< (student-birthmonth stud1) (student-birthmonth stud2)))
                          (and 
                            (= (student-birthyear stud1) (student-birthyear stud2)) 
                            (= (student-birthmonth stud1) (student-birthmonth stud2)) 
                            (< (student-birthday stud1) (student-birthday stud2)))))
                    ;;contract: treenode num -> treenode
                    ;;purpose:  inserts content into the sorted binary tree root and returns the new sorted binary tree
                    (define (tree-insert root content)
                      (cond 
                        [(empty? root) (make-treenode empty content empty)]
                        [(comp-student-age content (treenode-content root)) (make-treenode (tree-insert (treenode-left root) content) (treenode-content root) (treenode-right root))]
                        [else (make-treenode (treenode-left root) (treenode-content root) (tree-insert (treenode-right root) content))])))
              (if (empty? L) root (tree-insert-list (tree-insert root (first L)) (rest L)))))
          ;;contract: tree -> list
          ;;purpose:  outputs all elements of the tree in infix order
          ;;example: (flatten-tree empty (tree-insert-list empty '(5 6))) -> '(5 6)
          (define (flatten-tree root)
            (if (empty? root) 
                empty
                (append (flatten-tree (treenode-left root)) (cons (treenode-content root) (flatten-tree (treenode-right root)))))))
  (flatten-tree (tree-insert-list empty L))))

;;Test
(check-expect
 (sort-student-list-matrikel (list daniel gina guido melanie))
 (list melanie daniel guido gina ))


