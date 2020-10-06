#lang racket/base

(require racket/math)

(provide (all-defined-out))


(struct pvector
  (parts)
  #:transparent)

(define (make-pvector x y [z 0])
  (pvector (vector x y z)))

(define (pvec-x v)
  (vector-ref (pvector-parts v) 0))
(define (pvec-y v)
  (vector-ref (pvector-parts v) 1))
(define (pvec-z v)
  (vector-ref (pvector-parts v) 2))



(define (pvec+ u v)
  (pvector
   (for/vector ([ux (pvector-parts u)]
                [vx (pvector-parts v)])
     (+ ux vx))))

(define (pvec- u v)
  (pvector
   (for/vector ([ux (pvector-parts u)]
                [vx (pvector-parts v)])
     (+ ux vx))))

(define (pvec* v n)
  (pvector
   (for/vector ([vx (pvector-parts v)])
     (* vx n))))

(define (pvec/ v n)
  (pvector
   (for/vector ([vx (pvector-parts v)])
     (/ vx n))))


(define (pvec. u v)
  (for/fold ([sum 0])
            ([ux (pvector-parts u)]
             [vx (pvector-parts v)])
    (+ sum (* ux vx))))

(define (pvecx u v)
  (let* ([u* (pvector-parts u)]
         [v* (pvector-parts v)]
         [ux (vector-ref u* 0)]
         [uy (vector-ref u* 1)]
         [uz (vector-ref u* 2)]
         [vx (vector-ref v* 0)]
         [vy (vector-ref v* 1)]
         [vz (vector-ref v* 2)])
    (pvector (- (* uy vz) (* uz vy))
             (- (* uz vx) (* ux vz))
             (- (* ux vy) (* uy vx)))))


(define (pvec-magsq v)
  (for/fold ([sum 0])
            ([x (pvector-parts v)])
    (+ sum (* x x))))

(define (pvec-mag v)
  (sqrt (pvec-magsq v)))


(define (from-angle angle)
  (make-pvector (cos angle) (sin angle)))


(define (random-pvector [magnitude 1])
  (let* ([angle (* 2 pi (random))]
         [x (* magnitude (cos angle))]
         [y (* magnitude (sin angle))])
    (make-pvector x y)))


(define (pvector->list v)
  (vector->list (pvector-parts v)))
