#lang play
(require "T2.rkt")

(print-only-errors #t)

#| Tests Parte 1A |#
(test (parse 1) (num 1))
(test (parse '(+ 1 2)) (add (num 1) (num 2)))
(test (parse '(- 2 1)) (sub (num 2) (num 1)))
(test (parse '(* 5 7)) (mul (num 5) (num 7)))

(test (parse #t) (tt))
(test (parse #f) (ff))
(test (parse '(<= 1 2)) (leq (num 1) (num 2)))
(test (parse '(if #t 7 4)) (ifc (tt) (num 7) (num 4)))

(test (parse '(+ (- 10 4) (* 1 4))) (add (sub (num 10) (num 4)) (mul (num 1) (num 4))))
(test (parse '(- (if #t 2 5) (if #f 6 0))) (sub (ifc (tt) (num 2) (num 5)) (ifc (ff) (num 6) (num 0))))
(test (parse '(* (+ 4 92) (- 11 8))) (mul (add (num 4) (num 92)) (sub (num 11) (num 8))))
(test (parse '(<= (* 3 2) (+ 2 1))) (leq (mul (num 3) (num 2)) (add (num 2) (num 1))))
(test (parse '(if (<= 4 1) (+ 22 1) (- 32 5))) (ifc (leq (num 4) (num 1)) (add (num 22) (num 1)) (sub (num 32) (num 5))))

#| Tests Parte 1B |#
;; parse id test
(test (parse 'a) (id 'a))

;; parse fun tests
(test (parse '(fun () 1)) (fun (list) (num 1)))
(test (parse '(fun (x) x)) (fun (list 'x) (id 'x)))
(test (parse '(fun (y) 2)) (fun (list 'y) (num 2)))
(test (parse '(fun (a b) (+ a b))) (fun (list 'a 'b) (add (id 'a) (id 'b))))
(test (parse
       '(fun (m n o p) (if (<= (+ m n) (- o p)) (* n o) 1)))
      (fun (list 'm 'n 'o 'p)
           (ifc (leq (add (id 'm) (id 'n)) (sub (id 'o) (id 'p)))
                (mul (id 'n) (id 'o))
                (num 1)))) 

;; parse app tests
(test (parse '(abc)) (app (id 'abc) (list)))
(test (parse '(function 1)) (app (id 'function) (list (num 1))))
(test (parse '(f 3 4 5)) (app (id 'f) (list (num 3) (num 4) (num 5))))
(test (parse '(foo (+ 0 3) (* 5 0))) (app (id 'foo) (list (add (num 0) (num 3)) (mul (num 5) (num 0)))))


