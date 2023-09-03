#lang play
;; P3
;; Implemente la función (sumatoria a f b)
(define (sumatoria a f b)
  (if (> a b)
      0
      (+ (f a) (sumatoria (+ a 1) f b))))


(define (add-n-m)
  (+ n m))

(define (add-n n)
  (λ(m) (+ n m)))

(define (add-1 x)
  ((add-n 1) x)

(define (uncurry-2 f)
  λ(x y) ((f x) y))

      