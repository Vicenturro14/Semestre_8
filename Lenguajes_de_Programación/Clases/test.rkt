#lang racket
(define (my-max a b)
  (if (< a b)
      b
      a))

(define (pick-random a b)
  (if (< (random)0.5)
      a
      b))