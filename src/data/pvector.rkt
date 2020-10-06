#lang racket/base

(require "../private/data/pvector.rkt"
         racket/contract)


(provide (contract-out
          (rename make-pvector pvector
                  (->* (number? number?) (number?) pvector?))
          [pvector? (-> any/c boolean?)]
          [pvec-x (-> pvector? number?)]
          [pvec-y (-> pvector? number?)]
          [pvec-z (-> pvector? number?)]
          [pvec+ (-> pvector? pvector? pvector?)]
          [pvec- (-> pvector? pvector? pvector?)]
          [pvec* (-> pvector? number? pvector?)]
          [pvec/ (-> pvector? number? pvector?)]
          [pvec. (-> pvector? pvector? number?)]
          [pvecx (-> pvector? pvector? pvector?)]
          [pvec-mag (-> pvector? number?)]
          [pvec-magsq (-> pvector? number?)]
          [from-angle (-> number? pvector?)]
          [random-pvector (->* () (number?) pvector?)]
          [pvector->list (-> pvector? list?)]))
