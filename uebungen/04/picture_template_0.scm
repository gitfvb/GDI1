(define robocup ...)


;; Diese Funktion berechnet aus einer RBG Farbe den hue Wert
;; http://de.wikipedia.org/wiki/HSI-Farbmodell
;; http://de.wikipedia.org/wiki/RGB-Farbraum
(define (hue color)
  (local (
          (define r (/ (color-red color) 255))
          (define b (/ (color-blue color) 255))
          (define g (/ (color-green color) 255))
          (define (h x)
            (if (< x 0) (+ x 360) x)))
    (local (
            (define MAXIMUM (max r b g))
            (define MINIMUM (min r b g)))
      (local (
              (define (f a b) 
                (* (/ (- a b) (- MAXIMUM MINIMUM)) 60)))
        (cond
          [(= MINIMUM MAXIMUM) 0]
          [(= r MAXIMUM) (h (f g b)) ]
          [(= g MAXIMUM) (h (+ (f b r) 120))]
          [else (h (+ (f r g) 240)) ])))))

;;contract: copy: image -> image
;;purpose: copies an image
;;example: (copy robocup) -> robocup image
(define (copy img) 
  (color-list->image
   (image->color-list img)
   (image-width img)
   (image-height img)
   0
   0))


;;
;;
;;
(define (filter-img img f) ...)

;;
;;
;;
(define (check-pixel f) ...)

;;
;;
;;
(define (compare-hue h t) ... )


