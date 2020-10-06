#lang racket/base

(require racket/class "../pframe.rkt"
         "../color.rkt"
         (for-syntax racket/base syntax/parse)
         "param.rkt")


(provide background
         fill nofill
         stroke nostroke stroke-weight
         color-mode)



(define-syntax-rule (define-style-macro marco-id method)
  (define-syntax-rule (marco-id arg (... ...))
    (send current-frame method arg (... ...))))


(define-style-macro background background)
(define-style-macro fill set-fill)
(define-style-macro nofill set-no-fill)
(define-style-macro stroke set-stroke)
(define-style-macro nostroke set-no-stroke)
(define-style-macro stroke-weight set-stroke-weight)


(define-syntax-rule (color-mode mode)
  (current-color-mode mode))

