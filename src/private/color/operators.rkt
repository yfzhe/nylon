#lang racket/base

(require "data.rkt"
         "conversion.rkt")

(provide color? rgb?
         (rename-out [color/hsl? hsl?]
                     [color-red red]
                     [color-green green]
                     [color-blue blue]
                     [color-alpha alpha])
         hue saturation lightness)


(define (rgb? c)
  (and (color? c) (not (color/hsl? c))))


(define (hsl-property hsl-f rgb-f)
  (lambda (color)
    (cond
      [(color/hsl? color) (hsl-f color)]
      [else
       (rgb-f (rgb->hsl* (color-red color)
                         (color-green color)
                         (color-blue color)))])))

(define hue
  (hsl-property color/hsl-hue car))

(define saturation
  (hsl-property color/hsl-sat cadr))

(define lightness
  (hsl-property color/hsl-li caddr))

