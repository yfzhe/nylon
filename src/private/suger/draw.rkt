#lang racket/base

(require (prefix-in pr: "../draw/primitive.rkt")
         (for-syntax racket/base syntax/parse)
         "param.rkt")


(provide point line
         rect triangle quad
         ellipse arc
         lines polygon
         for/lines)



(define-syntax (define-draw-macro stx)
  (syntax-case stx (...)
    [(_ marco-id proc-id)
     #'(define-syntax (marco-id stx)
         (syntax-parse stx
           [(_ arg:expr (... ...)) #'(proc-id current-dc arg (... ...))]
           [_:id #'(lambda args (apply proc-id current-dc args))]))]))


(define-draw-macro point pr:point)
(define-draw-macro line pr:line)
(define-draw-macro rect pr:rect)
(define-draw-macro ellipse pr:ellipse)
(define-draw-macro arc pr:arc)
(define-draw-macro triangle pr:triangle)
(define-draw-macro quad pr:quad)
(define-draw-macro lines pr:lines)
(define-draw-macro polygon pr:polygon)



(define-syntax (for/lines stx)
  (syntax-case stx ()
    [(_ clauses body ... tail-expr)
     (with-syntax ([original stx])
       #'(let ([points
                (for/fold/derived
                    original ([points '()])
                  clauses
                  body ...
                  (cons tail-expr points))])
           (pr:lines points)))]))

