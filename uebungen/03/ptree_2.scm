;;recursive datastructure for trees
(define-struct treenode (left content right))

;;structure for the content of ptrees
(define-struct ptree-node (s p))

;;frequency of letters in english texts
(define freq (list
              (make-ptree-node 'a 0.0651738)
              (make-ptree-node 'b 0.0124248)
              (make-ptree-node 'c 0.0217339)
              (make-ptree-node 'd 0.0349835)
              (make-ptree-node 'e 0.1041442)
              (make-ptree-node 'f 0.0197881)
              (make-ptree-node 'g 0.0158610)
              (make-ptree-node 'h 0.0492888)
              (make-ptree-node 'i 0.0558094)
              (make-ptree-node 'j 0.0009033)
              (make-ptree-node 'k 0.0050529)
              (make-ptree-node 'l 0.0331490)
              (make-ptree-node 'm 0.0202124)
              (make-ptree-node 'n 0.0564513)
              (make-ptree-node 'o 0.0596302)
              (make-ptree-node 'p 0.0137645)
              (make-ptree-node 'q 0.0008606)
              (make-ptree-node 'r 0.0497563)
              (make-ptree-node 's 0.0515760)
              (make-ptree-node 't 0.0729357)
              (make-ptree-node 'u 0.0225134)
              (make-ptree-node 'v 0.0082903)
              (make-ptree-node 'w 0.0171272)
              (make-ptree-node 'x 0.0013692)
              (make-ptree-node 'y 0.0145984)
              (make-ptree-node 'z 0.0007836)
              (make-ptree-node 'space 0.1918182)))


;;a very simple codetree for testing purposes
(define simplecode 
  (make-treenode 
   (make-treenode 
    (make-treenode empty 'a empty) 
    'unused 
    (make-treenode empty 'b empty))
   'unused
   (make-treenode
    (make-treenode empty 'c empty) 
    'unused 
    (make-treenode empty 'd empty))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;helper function for turning ptree-nodes into one-element trees.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: ptree-node-or-ptree -> ptree
;;purpose: turns ptree-nodes into trees
;;example: (make-subtree  (make-treenode empty (make-ptree-node 'l 0.0331490) empty) -> 
;;              (make-treenode empty (make-ptree-node 'l 0.0331490) empty)
(define (make-subtree ptree-node-or-ptree)
  (if (treenode? ptree-node-or-ptree) ptree-node-or-ptree (make-treenode empty ptree-node-or-ptree empty)))

;;TEST
(check-expect 
 (make-subtree (make-ptree-node 'm 0.0202124))
 (make-treenode empty (make-ptree-node 'm 0.0202124) empty))

;;TEST
(check-expect 
 (make-subtree (make-treenode empty (make-ptree-node 'm 0.0202124) empty))
 (make-treenode empty (make-ptree-node 'm 0.0202124) empty))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: symbol treenode -> boolean
;;purpose: computes whether symbol is contained in the tree
;;example: (contains? 'a empty) -> false
(define (contains? symbol root)
  (and
   ;;empty tree does not contain symbol
   (not (empty? root))
   (or
    ;;symbol is contained, if it is in root and root is a leaf
    (and (symbol=? symbol (treenode-content root)) (empty? (treenode-left root)) (empty? (treenode-right root)))
    ;;or it is contained in the left subtree
    (contains? symbol (treenode-left root))
    ;;or it is contained in the right subtree
    (contains? symbol (treenode-right root)))))

;;TEST
(check-expect 
 (contains? 'e simplecode)
 false)

;;TEST
(check-expect
 (contains? 'c simplecode) 
 true)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: symbol tree -> list-of-bit
;;purpose: computes the code for symbol using tree as coding tree
;;example: (encode 'a simplecode) -> '(00)
(define (encode symbol root)
  (cond
    ;;found the symbol, done
    [(symbol=? symbol (treenode-content root)) empty]
    ;;symbol contained in left subtree -> go left prepend 0 to code and recurse with left subtree)
    [(contains? symbol (treenode-left root)) (cons '0 (encode symbol (treenode-left root)))]
    ;;symbol contained in right subtree -> go right prepend 1 to code and recurse with right subtree)
    [else (cons '1 (encode symbol (treenode-right root)))]))

;;TEST
(check-expect 
 (encode 'a simplecode)
 '(0 0))

;;TEST
(check-expect 
 (encode 'd simplecode)
 '(1 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: los tree -> list-of-list-of-bit
;;purpose: computes the code for symbols in los using tree as coding tree
;;example: (encode '(a b) simplecode) -> (list '(00) '(01))
(define (encode-list los root)
  (if (empty? los)
      empty
      (cons (encode (first los) root) (encode-list (rest los) root))))

;;TEST
(check-expect 
 (encode-list '(a d) simplecode)
 (list '(0 0) '(1 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;helper function get-p:
;;contract: ptree -> num
;;purpose: gets the probability from a node of a probability tree
;;example: (get-p (make-treenode empty (make-ptree-node 'a 0.0651738) empty) -> 0.0651738
(define (get-p n)
  (ptree-node-p (treenode-content n)))

;;TEST
(check-expect 
 (get-p (make-treenode empty (make-ptree-node 'a 123) empty))
 123)

;;some ptrees for testing purposes
(define ptree1 (make-treenode empty (make-ptree-node 'a 0.15) empty))
(define ptree2 (make-treenode empty (make-ptree-node 'b 0.2) empty))
(define ptree3 (make-treenode empty (make-ptree-node 'c 0.3) empty))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: list-of-ptree-node-or-ptrees
;;purpose: applies make-subtree to all elements of a list
;;example: (make-subtree-list (list ptree1) -> (list ptree1)
(define (make-subtree-list L)
  (if (empty? L)
      empty
      (cons (make-subtree (first L)) (make-subtree-list (rest L)))))

;;TEST
(check-expect 
 (make-subtree-list (list ptree1 (make-ptree-node 'b 0.2)))
 (list ptree1 ptree2))


(check-expect 
 (make-subtree-list empty)
 empty)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: list-of-ptrees -> list-of-ptrees
;;purpose:  sorts a list of ptrees by the probability of their root node
;;example:     0.8      0.7              0.7      0.8
;;            /   \    /   \       ->   /   \    /   \ 
;; copied from exercise 4 (sorting students), adapted the comparison function
(define (sort-ptree-list L) 
  (local
    ;;contract: treenode list -> treenode
    ;;purpose:  inserts all elements of list into the sorted binary tree root and returns the new sorted binary tree
    ((define (tree-insert-list root L)
       (local
         ;;contract: ptree-node ptree-node -> boolean
         ;;purpose:  returns whether the first ptree node's p is <= than the p or the second node
         ;;ONLY CHANGE THIS FUNCTION FROM EXERCISE 4!!!!
         ((define (comp-ptree r1 r2)
            (<= (get-p r1) (get-p r2)))
          ;;contract: treenode num -> treenode
          ;;purpose:  inserts content into the sorted binary tree root and returns the new sorted binary tree
          (define (tree-insert root content)
            (cond 
              ;; trivial: insert element in the empty tree
              [(empty? root) (make-treenode empty content empty)]
              ;; case1: element must be inserted in left subtree, return new
              ;; tree, where the left son contains the element, content and right son
              ;; remain unchanged
              [(comp-ptree content (treenode-content root)) 
               (make-treenode 
                (tree-insert (treenode-left root) content)
                (treenode-content root)
                (treenode-right root))]
              ;; case2: element must be inserted in right subtree, return new
              ;; tree, where the right son contains the element, content and left son
              ;; remain unchanged
              [else (make-treenode 
                     (treenode-left root) 
                     (treenode-content root) 
                     (tree-insert (treenode-right root) content))])))
         ;;apply tree-insert to all elements of a list
         (if (empty? L)
             root
             (tree-insert-list (tree-insert root (first L)) (rest L)))))
     ;;contract: tree -> list
     ;;purpose:  outputs all elements of the tree in infix order
     ;;example: (flatten-tree empty (tree-insert-list empty '(5 6))) -> '(5 6)
     (define (flatten-tree root)
       (if (empty? root) 
           empty
           (append 
            (flatten-tree (treenode-left root)) 
            (list (treenode-content root))
            (flatten-tree (treenode-right root))))))
    ;;insert elements into a binary tree, then output the tree in correct order
    (flatten-tree (tree-insert-list empty L))))


;;TEST
(check-expect 
 (sort-ptree-list (list ptree3 ptree2 ptree1))
 (list ptree1 ptree2 ptree3))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: list-of-ptrees -> ptree
;;purpose: builds a single ptree from the list of ptrees
;;example: (build-ptree (list ptree1 ptree2)
(define (build-ptree L)
  (if (empty? (rest L))
      ;; only one tree left in the list, so return this tree
      (first L)
      ;; more than one tree left, procede as described
      (local (
              ;;sort the list, so the first two trees in the list have the lowest 
              ;;probability
              (define sorted-list (sort-ptree-list L))
              ;; T1 is the tree with the lowest probability
              (define T1 (first sorted-list))
              ;; T2 is the tree with the second lowest probability
              (define T2 (first (rest sorted-list)))
              ;; T3 has T1 and T2 as subtree, content as described
              (define T3 (make-treenode
                          T1
                          (make-ptree-node
                           'unused
                           (+ 
                            (get-p T1) 
                            (get-p T2)))
                          T2))
               (define list-without-T1-and-T2 (rest (rest sorted-list))))
        ;;recurse with T3 but without T1 and T2
        (build-ptree (cons T3 list-without-T1-and-T2)))))

;;TEST
(check-expect 
 (build-ptree (list ptree1 ptree2 ptree3))
 (make-treenode
  ptree3
  (make-ptree-node 'unused 0.65)
  (make-treenode
   ptree1
   (make-ptree-node 'unused 0.35)
   ptree2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: symbol ptree -> boolean
;;purpose: returns whether a symbol is contained in a tree
;;example: (ptree-contains? 'a ptreecode) -> true
(define (ptree-contains? symbol root)
  (and
   ;;empty tree does not contain symbol
   (not (empty? root))
   (or
    ;;symbol is contained, if it is in root and root is a leaf (last part is optional)
    (and 
     ;;adapted from contains? the symbol must be accessed via ptree-node-s
     (symbol=? symbol (ptree-node-s (treenode-content root)))
     ;;optionally checking if the node is a leaf
     (empty? (treenode-left root))
     (empty? (treenode-right root)))
    ;;or it is contained in the left subtree
    (ptree-contains? symbol (treenode-left root))
    ;;or it is contained in the right subtree
    (ptree-contains? symbol (treenode-right root)))))

;;TEST
(check-expect 
 (ptree-contains? 'c ptree3)
 true)

;;TEST
(check-expect 
 (ptree-contains? 'c (make-treenode empty (make-ptree-node 'unused 0.9)  ptree3))
 true)

;;contract: ptree-encode: symbol ptree -> list-of-bit
;;purpose: computes the code for symbol using ptree as coding tree
;;example: (ptree-encode 'a (make-treenode ptree1 'unused ptree3)) -> '(0)
;;adapted from encode the symbol must be accessed via ptree-node-s,
;;use ptree-contains? instead of contains?
(define (ptree-encode symbol root)
  (cond
    ;;found the symbol, done
    [(symbol=? symbol (ptree-node-s (treenode-content root))) empty]
    ;;symbol contained in left subtree -> go left prepend 0 to code and recurse)
    [(ptree-contains? symbol (treenode-left root)) (cons '0 (ptree-encode symbol (treenode-left root)))]
    ;;symbol contained in right subtree -> go right prepend 1 to code and recurse)
    [else (cons '1 (ptree-encode symbol (treenode-right root)))]))

;;TEST
(check-expect 
 (ptree-encode 'a (make-treenode ptree1 (make-ptree-node 'unused 0.9) ptree3))
 '(0))


;;contract: ptree-encode-list: symbol ptree -> list-of-bit
;;purpose: computes the code for symbols in los using ptree as coding tree
;;example: (ptree-encode-list '(a c a) (make-treenode ptree1 'unused ptree3)) ->
;;    (list '(0) '(1) '(0))
;;adapted from encode-list, use ptree-encode instead of encode
(define (ptree-encode-list los root)
  (if (empty? los)
      empty
      (cons (ptree-encode (first los) root) (ptree-encode-list (rest los) root))))

;;TEST
(check-expect
 (ptree-encode-list '(g d i space i s t space t o l l) (build-ptree (make-subtree-list freq)))
 
 (list
  '(1 0 0 0 1 1)
  '(1 1 0 1 0)
  '(0 1 1 0)
  '(1 1 1)
  '(0 1 1 0)
  '(0 0 1 1)
  '(1 1 0 0)
  '(1 1 1)
  '(1 1 0 0)
  '(1 0 0 1)
  '(1 0 1 1 0)
  '(1 0 1 1 0)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ptree-encode-list '(i n f o r m a t i k space m a c h t space s p a s s) (build-ptree (make-subtree-list freq)))