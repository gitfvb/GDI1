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

;;test
(check-expect
	(tree-insert-list empty '(5))
	(make-treenode empty 5 empty))

;;test
(check-expect
	(tree-insert-list empty '(5 6))
	(make-treenode empty 5 (make-treenode empty 6 empty)))