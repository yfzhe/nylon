#lang racket/base
(require racket/class racket/gui/base
         "color.rkt")

(provide pframe%)

(define pframe%
  (class frame%
    ;; init arguments
    (init setup)
    (init draw)
    (init-field [canvas-width 100])
    (init-field [canvas-height 100])

    (define frame-rate 30)
    (define frame-count 0)

    (define pen-color (make-color 0 0 0))
    (define pen-weight 1)
    (define pen-style 'solid)

    (define brush-color (make-color 255 255 255))
    (define brush-style 'solid)

    ;; init this frame and add some componments
    (super-new)

    (define canvas
      (new canvas%
           [parent this]
           [paint-callback
            (lambda (canvas dc) (draw this canvas dc))]
           [min-width canvas-width]
           [min-height canvas-height]))

    (define dc (send canvas get-dc))

    (define timer
      (new timer%
           [notify-callback
            (lambda ()
              (draw this canvas dc)
              (set! frame-count (add1 frame-count)))]))


    ;; methods
    ;; environment
    (define/override (get-width) canvas-width)

    (define/override (get-height) canvas-height)

    (define/public (set-width new-width)
      (send canvas min-width new-width)
      (send this min-width new-width))

    (define/public (set-height new-height)
      (send canvas min-height new-height)
      (send this min-height new-height))


    (define/public (smoothing-mode mode)
      (send dc set-smoothing mode))


    ;; mouse position
    (define/public (get-mouse-x*)
      (let-values ([(mouse key) (get-current-mouse-state)])
        (- (send mouse get-x) (send this get-x) 6)))

    (define/public (get-mouse-y*)
      (let-values ([(mouse key) (get-current-mouse-state)])
        (- (send mouse get-y) (send this get-y) 28)))

    ;; control
    (define/public (redraw)
      (send timer notify))
    (define/public (loop [rate 30])
      (send timer start (round (/ 1000 rate))))
    (define/public (noloop)
      (send timer stop))


    ;; style
    (define/public (background . args)
      (send dc set-background
            (color->color% (apply color args)))
      (send dc erase))

    (define/public (set-fill . args)
      (set! brush-color
            (color->color% (apply color args)))
      (send dc set-brush brush-color brush-style))

    (define/public (set-no-fill)
      (set! brush-style 'transparent)
      (send dc set-brush brush-color brush-style))

    (define/public (set-stroke . args)
      (set! pen-color
            (color->color% (apply color args)))
      (send dc set-pen pen-color pen-weight pen-style))

    (define/public (set-no-stroke . args)
      (set! pen-style 'transparent)
      (send dc set-pen pen-color pen-weight pen-style))

    (define/public (set-stroke-weight w)
      (set! pen-weight w)
      (send dc set-pen pen-color pen-weight pen-style))


    ;; make this pframe show
    (send canvas set-canvas-background
          (make-color 204 204 204))
    (smoothing-mode 'aligned)

    (inherit show) (show #t)

    (loop 60)

    (setup this canvas dc)))
