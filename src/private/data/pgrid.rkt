#lang racket/base

(provide (all-defined-out))


(struct pgrid
  (row col cells))

(define (make-pgrid row col [v 0])
  (pgrid row col (make-vector (* row col) v)))


(define (pgrid-ref pgrid i j)
  (define row (pgrid-row pgrid))
  (define col (pgrid-col pgrid))
  (define cells (pgrid-cells pgrid))

  (when (>= i row)
    (raise-arguments-error 'pgird "row index is out of range" i))
  (when (>= j col)
    (raise-arguments-error 'pgrid "column index is out of range" j))

  (define index (+ (* i col) j))
  (vector-ref cells index))


(define (pgrid-ref/row pgrid i)
  (define row (pgrid-row pgrid))
  (define col (pgrid-col pgrid))
  (define cells (pgrid-cells pgrid))

  (when (>= i row)
    (raise-arguments-error 'pgird "row index is out of range" i))

  (for/vector #:length col ([j (in-range col)])
    (define index (+ (* i col) j))
    (vector-ref cells index)))


(define (pgrid-ref/column pgrid j)
  (define row (pgrid-row pgrid))
  (define col (pgrid-col pgrid))
  (define cells (pgrid-cells pgrid))

  (when (>= j col)
    (raise-arguments-error 'pgrid "column index is out of range" j))

  (for/vector #:length row ([i (in-range row)])
    (define index (+ (* i col) j))
    (vector-ref cells index)))


(define (pgrid-set! pgrid i j v)
  (define row (pgrid-row pgrid))
  (define col (pgrid-col pgrid))
  (define cells (pgrid-cells pgrid))

  (when (>= i row)
    (raise-arguments-error 'pgird "row index is out of range" i))
  (when (>= j col)
    (raise-arguments-error 'pgrid "column index is out of range" j))

  (define index (+ (* i col) j))
  (vector-set! cells index v))
