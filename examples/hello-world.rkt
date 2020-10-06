#lang racket/base

(require processing)

(define/env setup
  (fill 255 255 255))

(define/env draw
  (ellipse mouse-x mouse-y 50 50))

(processing (label "Hello World")
            (size 400 400)
            (on-setup setup)
            (on-draw draw))
