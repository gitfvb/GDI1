(define-struct treenode (left content right))

;;contract: treenode num -> treenode
;;purpose:  inserts content into the sorted binary tree root and returns the new sorted binary tree
;;example: (tree-insert empty 3) -> (make-treenode empty 3 empty)
(define (tree-insert root content)
  (cond 
    [(empty? root) (make-treenode empty content empty)]
    [(<= content (treenode-content root)) (make-treenode (tree-insert (treenode-left root) content) (treenode-content root) (treenode-right root))]
    [else (make-treenode (treenode-left root) (treenode-content root) (tree-insert (treenode-right root) content))]))

;;Test
(check-expect (tree-insert empty 5) (make-treenode empty 5 empty))

;;Test
(check-expect (tree-insert (make-treenode empty 5 empty) 6) (make-treenode empty 5 (make-treenode empty 6 empty)))
