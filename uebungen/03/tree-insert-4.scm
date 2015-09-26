;;contract: lon -> lon
;;purpose:  sorts a list of numbers
;;example: (sort-list '(1 3 2)) -> '(1 2 3)
(define (sort-list L) 
  (local (
          (define-struct treenode (left content right))
          ;;contract: treenode list -> treenode
          ;;purpose:  inserts all elements of list into the sorted binary tree root and returns the new sorted binary tree
          ;;example: (tree-insert-list empty '(3)) -> (make-treenode empty 3 empty)
          (define (tree-insert-list root L)
            (local (
                    ;;contract: treenode num -> treenode
                    ;;purpose:  inserts content into the sorted binary tree root and returns the new sorted binary tree
                    ;;example: (tree-insert empty 3) -> (make-treenode empty 3 empty)
                    (define (tree-insert root content)
                      (cond 
                        [(empty? root) (make-treenode empty content empty)]
                        [(<= content (treenode-content root)) (make-treenode (tree-insert (treenode-left root) content) (treenode-content root) (treenode-right root))]
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

;;test
(check-expect (sort-list '(5 6)) '(5 6))
;;test
(check-expect (sort-list '(6 5)) '(5 6))

