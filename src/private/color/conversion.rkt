#lang typed/racket/base

(provide  rgb->hsl* hsl->rgb*)


;;; Color-List
;;; The tulpe capture the three parts of one color
(define-type Color-List
  (List Inexact-Real Inexact-Real Inexact-Real))


;;; normalize and denormalize
;;; rgb => [0, 255]^3 <-> [0, 1]^3
;;; hsl => [0, 255]^3 <-> [0, 360) * [0, 1] * [0, 1]
(: rgb-normalize (-> Color-List Color-List)) 
(define (rgb-normalize rgb)
  (define r (car rgb))
  (define g (cadr rgb))
  (define b (caddr rgb))
  (list (/ r 255) (/ g 255) (/ b 255)))

(: rgb-denormalize (-> Color-List Color-List))
(define (rgb-denormalize rgb*)
  (define r (car rgb*))
  (define g (cadr rgb*))
  (define b (caddr rgb*))
  (list (* r 255) (* g 255) (* b 255)))


(: hsl-normalize (-> Color-List Color-List))
(define (hsl-normalize hsl)
  (define h (car hsl))
  (define s (cadr hsl))
  (define l (caddr hsl))
  (list (* (/ h 255) 360) (/ s 255) (/ l 255)))

(: hsl-denormalize (-> Color-List Color-List))
(define (hsl-denormalize hsl*)
  (define h (car hsl*))
  (define s (cadr hsl*))
  (define l (caddr hsl*))
  (list (/ (* h 255) 360) (* s 255) (* l 255)))



(: rgb->hsl (-> Color-List Color-List))
(define (rgb->hsl rgb)
  (define rgb* (rgb-normalize rgb))
  (define r (car rgb*))
  (define g (cadr rgb*))
  (define b (caddr rgb*))
  
  (define ma (max r g b))
  (define mi (min r g b))
  
  (define h
    (cond
      [(= ma mi) 0.0]
      [(and (= ma r) (>= g b))
       (* 60 (/ (- g b) (- ma mi)))]
      [(= ma r)
       (+ (* 60 (/ (- g b) (- ma mi))) 360)]
      [(= ma g)
       (+ (* 60 (/ (- b r) (- ma mi))) 120)]
      [else
       (+ (* 60 (/ (- r g) (- ma mi))) 240)]))

  (define l
    (/ (+ ma mi) 2))
  
  (define s
    (cond
      [(or (zero? l) (= ma mi)) 0.0]
      [(<= l 0.5)
       (/ (- ma mi) (* 2 l))]
      [else
       (/ (- ma mi) (- 2 (* 2 l)))]))

  (hsl-denormalize (list h s l)))



(: hsl->rgb (-> Color-List Color-List))
(define (hsl->rgb hsl)
  (define hsl* (hsl-normalize hsl))
  (define h (car hsl*))
  (define s (cadr hsl*))
  (define l (caddr hsl*))

  (define rgb*
    (cond
      [(zero? s) (list l l l)]
      [else
       (define q
         (if (< l 0.5)
             (* l (+ 1 s))
             (+ l s (- (* l s)))))
       (define p (- (* 2 l) q))
     
       (define hk (/ h 360))
       (define tr (+ hk 1/3))
       (define tg hk)
       (define tb (- hk 1/3))

       (: normalize (-> Real Real))
       (define (normalize tc)
         (cond
           [(< tc 0) (+ tc 1)]
           [(> tc 1) (- tc 1)]
           [else tc]))

       (: colorc (-> Real Real))
       (define (colorc tc)
         (define tc*
           (cond
             [(< tc 0) (+ tc 1)]
             [(> tc 0) (- tc 1)]
             [else tc]))
         (cond
           [(< tc 1/6) (+ p (* (- q p) 6 tc*))]
           [(< tc 1/2) q]
           [(< tc 2/3) (+ p (* (- q p) 6 (- 2/3 tc*)))]
           [else p]))


       (list tr tg tb)]))

  (rgb-denormalize rgb*))



;;; rgb->hsl*, hsl->rgb*
;;; convert exact number to inexact
(define-type Color-List*
  (List Real Real Real))

(: ->inexact (-> Real Inexact-Real))
(define (->inexact n)
  (if (inexact? n)
      n
      (exact->inexact n)))

(: rgb->hsl* (-> Real Real Real Color-List))
(define (rgb->hsl* r g b)
  (rgb->hsl
   (list (->inexact r) (->inexact g) (->inexact b))))

(: hsl->rgb* (-> Real Real Real Color-List))
(define (hsl->rgb*  h s l)
  (hsl->rgb
   (list (->inexact h) (->inexact s) (->inexact l))))

