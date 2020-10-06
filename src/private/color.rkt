#lang racket/base

(require "color/data.rkt"
         "color/make.rkt"
         "color/operators.rkt")


(provide current-color-mode
         (rename-out [make-color color])
         color? rgb? hsl?
         red green blue
         hue saturation lightness
         alpha
         color->color%)

