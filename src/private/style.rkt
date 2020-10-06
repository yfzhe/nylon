#lang racket/base

(require racket/class
         "pframe.rkt")

(provide background
         fill nofill
         stroke nostroke stroke-weight)


(define (background frame . color-args)
  (send frame background . color-args))

(define (fill frame . color-args)
  (send frame set-fill . color-args))

(define (nofill frame)
  (send frame set-no-fill))

(define (stroke frame . color-args)
  (send frame set-stroke . color-args))

(define (nostroke frame)
  (send frame set-no-stroke))

(define (stroke-weight frame weight)
  (send frame set-stroke-weight weight))
