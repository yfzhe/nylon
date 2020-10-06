#lang racket/base

(require "../private/data/pgrid.rkt"
         racket/contract)


(provide (contract-out
          [pgrid? (-> any/c boolean?)]
          [make-pgrid (->* (exact-nonnegative-integer? exact-nonnegative-integer?) (any/c) pgrid?)]
          [pgrid-ref (-> pgrid? exact-nonnegative-integer? exact-nonnegative-integer? any/c)]
          [pgrid-set! (-> pgrid? exact-nonnegative-integer? exact-nonnegative-integer? any/c any/c)]
          [pgrid-ref/row (-> pgrid? exact-nonnegative-integer? vector?)]
          [pgrid-ref/column (-> pgrid? exact-nonnegative-integer? vector?)]))
