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
;;contract:
;;purpose:
;;example:


;;TEST
(check-expect 
 (contains? 'e simplecode)
 ...)

;;TEST
(check-expect
 (contains? 'c simplecode) 
 ...)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract:
;;purpose:
;;example:

;;TEST
(check-expect 
 (encode 'a simplecode)
 ...)

;;TEST
(check-expect 
 (encode 'd simplecode)
 ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: 
;;purpose:
;;example: 

;;TEST
(check-expect 
 (encode-list '(a d) simplecode)
 ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;some ptrees for testing purposes
(define ptree1 (make-treenode empty (make-ptree-node 'a 0.1) empty))
(define ptree2 (make-treenode empty (make-ptree-node 'b 0.2) empty))
(define ptree3 (make-treenode empty (make-ptree-node 'c 0.3) empty))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: 
;;purpose: 
;;example: 

;;TEST
(check-expect 
 (make-subtree-list (list ptree1 (make-ptree-node 'b 0.2)))
 (list ptree1 ptree2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: 
;;purpose:  
;;example:     0.8      0.7              0.7      0.8
;;            /   \    /   \       ->   /   \    /   \ 

;;TEST
(check-expect 
 (sort-ptree-list (list ptree3 ptree2 ptree1))
 (list ptree1 ptree2 ptree3))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: 
;;purpose: 
;;example: 

;;TEST
(check-expect 
 (build-ptree (list ptree1 ptree2 ptree3))
 (make-treenode
  ptree3
  (make-ptree-node 'unused 0.6)
  (make-treenode
   ptree1
   (make-ptree-node 'unused 0.3)
   ptree2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;contract: 
;;purpose: 
;;example: 

;;TEST
(check-expect 
 (ptree-contains? 'c ptree3)
 true)

;;TEST
(check-expect 
 (ptree-contains? 'c (make-treenode empty (make-ptree-node 'unused 0.9)  ptree3))
 true)

;;contract: 
;;purpose: 
;;example: 

;;TEST
(check-expect 
 (ptree-encode 'a (make-treenode ptree1 (make-ptree-node 'unused 0.9) ptree3))
 '(0))


;;contract: 
;;purpose:
;;example: 

;;TEST
(check-expect
 (ptree-encode-list '(g d i space i s t space t o l l) (build-ptree (make-subtree-list freq)))
 (list '(1 0 0 0 1 1) '(1 1 0 1 0) '(0 1 1 0) '(1 1 1) '(0 1 1 0) '(0 0 1 1) '(1 1 0 0) '(1 1 1) '(1 1 0 0) '(1 0 0 1) '(1 0 1 1 0) '(1 0 1 1 0)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;TASK 5.2.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

