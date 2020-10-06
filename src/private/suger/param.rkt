#lang racket/base

(require racket/stxparam
         (for-syntax racket/base))

(provide current-frame
         current-canvas
         current-dc)

(define-syntax-parameter current-frame #f)
(define-syntax-parameter current-canvas #f)
(define-syntax-parameter current-dc #f)
