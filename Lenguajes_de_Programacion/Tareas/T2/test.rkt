#lang play
(require "T2.rkt")

#| Tests Parte 1A |#
(test (parse 1) (num 1))
(test (parse '(+ 1 2)) (add (num 1) (num 2)))
(test (parse '(- 2 1)) (sub (num 2) (num 1)))
(test (parse '(* 5 7)) (mul (num 5) (num 7)))

(test (parse #t) (tt))
(test (parse #f) (ff))
(test (parse '(<= 1 2)) (leq (num 1) (num 2)))
(test (parse '(if #t 7 4)) (ifc (tt) (num 7) (num 4)))
(test (parse 'a) (id 'a))

(test (parse '(+ (- 10 4) (* 1 4))) (add (sub (num 10) (num 4)) (mul (num 1) (num 4))))
(test (parse '(- (if #t 2 5) (if #f 6 0))) (sub (ifc (tt) (num 2) (num 5)) (ifc (ff) (num 6) (num 0))))
(test (parse '(* (+ 4 92) (- 11 8))) (mul (add (num 4) (num 92)) (sub (num 11) (num 8))))
(test (parse '(<= (* 3 2) x)) (leq (mul (num 3) (num 2)) (id 'x)))
(test (parse '(if (<= 4 1) (+ 22 1) (- 32 5))) (ifc (leq (num 4) (num 1)) (add (num 22) (num 1)) (sub (num 32) (num 5))))

(print-only-errors #t)
