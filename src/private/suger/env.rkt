#lang racket/base

(require (for-syntax racket/base syntax/parse)
         racket/stxparam "param.rkt"
         racket/class
         "../pframe.rkt")

(provide processing
         define/env
         mouse-x mouse-y
         redraw loop noloop)


(define-syntax (processing stx)
  (syntax-parse stx
    #:datum-literals (label size on-setup on-draw)
    [(_ (~optional (label label-arg:string))
        (~optional (size width-arg:expr height-arg:expr))
        (on-setup setup-arg:expr)
        (on-draw draw-arg:expr))
     (with-syntax ([label-arg (or (attribute label-arg) "Processing.rkt")]
                   [width-arg (or (attribute width-arg) 400)]
                   [height-arg (or (attribute height-arg) 400)])
       #'(define env
           (new pframe%
                [label label-arg]
                [width width-arg]
                [height height-arg]
                [setup setup-arg]
                [draw draw-arg])))]))



(define-syntax (define/env stx)
  (syntax-parse stx
    [(_ name:id body:expr ...+)
     #'(define (name frame canvas dc)
         (syntax-parameterize
             ([current-frame (make-rename-transformer #'frame)]
              [current-canvas (make-rename-transformer #'canvas)]
              [current-dc (make-rename-transformer #'dc)])
           body ...))]))


(define-syntax (mouse-x stx)
  (syntax-parse stx
    [_:id
     #'(send current-frame get-mouse-x*)]))

(define-syntax (mouse-y stx)
  (syntax-parse stx
    [_:id
     #'(send current-frame get-mouse-y*)]))


(define-syntax-rule (redraw)
  (send current-frame redraw))

(define-syntax-rule (loop)
  (send current-frame loop 30))

(define-syntax-rule (noloop)
  (send current-frame noloop))
