#lang racket/base

(require "data.rkt"
         "conversion.rkt"
         racket/draw racket/class
         racket/match racket/math)


(provide color->color%
         current-color-mode
         make-color)

;;; color->color%:
;;; build a color% object for a color struct
(define (color->color% color)
  (make-object color%
    (exact-floor (color-red color))
    (exact-floor (color-green color))
    (exact-floor (color-blue color))
    (color-alpha color)))


;;; current-color-mode: parameter
;;; 'rgb | 'hsl 
(define current-color-mode
  (make-parameter 'rgb))


;;; hex: build a rgb color from a hex string
(define (char->hex-digit char)
  (cond
    [(char<=? #\0 char #\9)
     (- (char->integer char) 48)]
    [(char<=? #\A char #\F)
     (- (char->integer char) 55)]
    [(char<=? #\a char #\f)
     (- (char->integer char) 87)]))

(define (chars->numbers chars)
  (cond
    [(null? chars) '()]
    [else
     (let* ([high (char->hex-digit (car chars))]
            [low (char->hex-digit (cadr chars))]
            [num (+ (* high 16) low)])
       (cons num (chars->numbers (cddr chars))))]))


(define (hex hex-str)
  (let ([hex-len (string-length hex-str)]
        [chars (string->list hex-str)])
    (unless (or (= hex-len 7) (= hex-len 9)
                (char=? (car chars) #\#))
      (raise-arguments-error 'color "the hex is illegal"))

    (match (chars->numbers (cdr chars))
      [(list r g b)   (color r g b 1.0)]
      [(list r g b a) (color r g b a)])))
      



(define (from-hsl hue sat li alpha)
  (let* ([rgb (hsl->rgb* hue sat li)]
         [r (car rgb)]
         [g (cadr rgb)]
         [b (caddr rgb)])
    (color/hsl r g b alpha hue sat li)))


(define make-color
  (let ([default-alpha 1.0])
    (case-lambda
      [(v)
       (cond
         [(number? v) (color v v v default-alpha)]
         [(string? v) (hex v)]
         [else (raise-argument-error 'color)])]
      [(v1 v2 v3)
       (case (current-color-mode)
         [(rgb) (color v1 v2 v3 default-alpha)]
         [(hsl) (from-hsl v1 v2 v3 default-alpha)])]
      [(v1 v2 v3 alpha)
       (case (current-color-mode)
         [(rgb) (color v1 v2 v3 alpha)]
         [(hsl) (from-hsl v1 v2 v3 alpha)])])))

