#lang info

(define collection "processing")
(define version "0.3")

(define pkg-desc "Processing in racket")
(define pkg-authors '(yfzhe))

(define deps '("base"))
(define build-deps '("scribble-lib"
                     "racket-doc"
                     "rackunit-lib"))
