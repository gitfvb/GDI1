;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ueb6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(define (make-new-obj)
  (local (
          (define state 0))
    (lambda (method params)
      (cond
        [(symbol=? 'set method)
         ((lambda (p1) (set! state p1)) (first params))]
        [(symbol=? 'get method) state]
        [else (error "message not understood")]))))

(define o (make-new-obj))