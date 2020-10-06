#lang racket/base

(require processing)

(define/env setup
  (noloop)
  (color-mode 'rgb))


(define/env draw
  (background 255)
  (for* ([x (in-range 256)]
         [y (in-range 256)])
    (stroke x y 255)
    (point x y)))


(processing (label "Color")
            (size 256 256)
            (on-setup setup)
            (on-draw draw))
