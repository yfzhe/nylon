#lang racket/base

(require racket/class racket/draw
         (for-syntax racket/base))

(provide point line
         rect triangle quad
         ellipse arc 
         lines polygon)


(define (point dc x y)
  (send dc draw-point x y))

(define (line dc x1 y1 x2 y2)
  (send dc draw-line x1 y1 x2 y2))

(define rect
  (case-lambda
    [(dc x y w h)
     (send dc draw-rectangle x y w h)]
    [(dc x y w h r)
     (send dc draw-rounded-rectangle x y w h r)]))


(define (ellipse dc x y w h)
  (send dc draw-ellipse (- x (/ w 2)) (- y (/ w 2)) w h))

(define (arc dc x y w h start end)
  (send dc draw-arc x y w h start end))


(define (triangle dc x1 y1 x2 y2 x3 y3)
  (send dc draw-polygon
        `((,x1 . ,y1) (,x2 . ,y2) (,x3 . ,y3))))

(define (quad dc x1 y1 x2 y2 x3 y3 x4 y4)
  (send dc draw-polygon
        `((,x1 . y1) (,x2 . ,y2) (,x3 . ,y3) (,x4 . ,y4))))


(define (lines dc points [x-offset 0] [y-offset 0])
  (send dc draw-lines points x-offset y-offset))

(define (polygon dc points [x-offset 0] [y-offset 0])
  (send dc draw-polygon points x-offset y-offset))



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
           (lines points)))]))

