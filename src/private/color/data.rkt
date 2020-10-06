#lang racket/base

(require racket/match)


(provide (struct-out color)
         (struct-out color/hsl))

;;; 0 <= r, g, b <= 255
(struct color
  (red green blue alpha)
  #:methods gen:custom-write
  [(define (write-proc color port mode)
     (fprintf port (if mode "#<color/rgb: " "(color/rgb "))
     (fprintf port "~a ~a ~a"
              (color-red color)
              (color-green color)
              (color-blue color))
     (when (< (color-alpha color) 1.0)
       (fprintf port " ~a" (color-alpha color)))
     (fprintf port (if mode ">" ")")))])


(struct color/hsl color
  (hue sat li)
  #:methods gen:custom-write
  [(define (write-proc color port mode)
     (fprintf port (if mode "#<color/hsl: " "(color/hsl "))
     (fprintf port "~a ~a ~a"
              (color/hsl-hue color)
              (color/hsl-sat color)
              (color/hsl-li color))
     (when (< (color-alpha color) 1.0)
       (fprintf port " ~a" (color-alpha color)))
     (fprintf port (if mode ">" ")")))])

