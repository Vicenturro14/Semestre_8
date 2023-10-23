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
;; parse tests
;; id
(test (parse 'a) (id 'a))

;; fun
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

;; app
(test (parse '(abc)) (app (id 'abc) (list)))
(test (parse '(function 1)) (app (id 'function) (list (num 1))))
(test (parse '(f 3 4 5)) (app (id 'f) (list (num 3) (num 4) (num 5))))
(test (parse '(foo (+ 0 3) (* 5 0))) (app (id 'foo) (list (add (num 0) (num 3)) (mul (num 5) (num 0)))))


#| Tests Parte 1D |#
;; num2num-op
;; La función num2num-op queda testeada con los tests de las funciones num+, num- y num*,
;; porque estas fueron implementadas con num2num-op.

;; num+ tests
(test (num+ (numV 0) (numV 0)) (numV 0))
(test (num+ (numV 1) (numV 2)) (numV 3))
(test/exn (num+ (numV 1) (boolV #f)) "num-op: invalid operands")
(test/exn (num+ (boolV #t) (numV 5)) "num-op: invalid operands")
(test/exn (num+ (boolV #f) (boolV #t)) "num-op: invalid operands")

;; num- tests
(test (num- (numV 4) (numV 4)) (numV 0))
(test (num- (numV 62) (numV 24)) (numV 38))
(test/exn (num- (numV 1) (boolV #f)) "num-op: invalid operands")
(test/exn (num- (boolV #t) (numV 5)) "num-op: invalid operands")
(test/exn (num- (boolV #f) (boolV #t)) "num-op: invalid operands")

;; num* tests
(test (num* (numV 0) (numV 4)) (numV 0))
(test (num* (numV 1) (numV 2)) (numV 2))
(test/exn (num* (numV 1) (boolV #f)) "num-op: invalid operands")
(test/exn (num* (boolV #t) (numV 5)) "num-op: invalid operands")
(test/exn (num* (boolV #f) (boolV #t)) "num-op: invalid operands")

;; num2bool-op
;; La función num2bool-op queda testeada con los test de la función num<=,
;; porque esta fue implementada con num2bool-op.

;; num<= tests
(test (num<= (numV 1) (numV 1)) (boolV #t))
(test (num<= (numV 23) (numV 10)) (boolV #f))
(test (num<= (numV 2) (numV 13)) (boolV #t))
(test/exn (num<= (numV 1) (boolV #f)) "num-op: invalid operands")
(test/exn (num<= (boolV #t) (numV 5)) "num-op: invalid operands")
(test/exn (num<= (boolV #f) (boolV #t)) "num-op: invalid operands")


#| Tests Parte 1E |#
;; multi-extend-env tests
(test (multi-extend-env (list) (list) (mtEnv)) (mtEnv))
(test (multi-extend-env (list 'a) (list (numV 1)) (mtEnv)) (aEnv 'a (numV 1) (mtEnv)))
(test (multi-extend-env (list 'b 'c) (list (boolV #t) (boolV #f)) (mtEnv))
      (aEnv 'c (boolV #f) (aEnv 'b (boolV #t) (mtEnv))))

;; eval tests
;; num
(test (eval (num 2) (mtEnv)) (numV 2))
;; id
(test (eval (id 'x) (aEnv 'x (numV 1) (mtEnv))) (numV 1))
(test (eval (id 'v) (aEnv 'v (boolV #t) (mtEnv))) (boolV #t))
;; add
(test (eval (parse '(+ 4 5)) (mtEnv)) (numV 9))
(test (eval (parse '(+ a b)) (aEnv 'a (numV 87) (aEnv 'b (numV 0) (mtEnv)))) (numV 87))
(test (eval (parse '(+ (- 3 0) (+ 1 2))) (mtEnv)) (numV 6))
;; sub
(test (eval (parse '(- 12 3)) (mtEnv)) (numV 9))
(test (eval (parse '(- m n)) (aEnv 'n (numV 6) (aEnv 'm (numV 1) (mtEnv)))) (numV -5))
(test (eval (parse '(- (+ 1 3) 1)) (mtEnv)) (numV 3))
;; mul
(test (eval (parse '(* 4 0)) (mtEnv)) (numV 0))
(test (eval (parse '(* f g)) (aEnv 'f (numV 2) (aEnv 'g (numV 4) (mtEnv)))) (numV 8))
(test (eval (parse '(* 2 (+ 1 0))) (mtEnv)) (numV 2))
;; tt
(test (eval (tt) (mtEnv)) (boolV #t))
;; ff
(test (eval (ff) (mtEnv)) (boolV #f))
;; leq
(test (eval (parse '(<= 1 2)) (mtEnv)) (boolV #t))
(test (eval (parse '(<= a z)) (aEnv 'a (numV 4) (aEnv 'z (numV -4) (mtEnv)))) (boolV #f))
;; ifc
(test (eval (parse '(if #t 5 3)) (mtEnv)) (numV 5))
(test (eval (parse '(if f n1 n2))
            (aEnv 'f (boolV #f) (aEnv 'n1 (numV 24) (aEnv 'n2 (numV 4) (mtEnv)))))
      (numV 4))
(test (eval (parse '(if (<= 2 0) (* 8 5) (- 2 4))) (mtEnv)) (numV -2))
;; fun
(test (eval (parse '(fun () #f)) (mtEnv)) (closureV (list) (ff) (mtEnv)))
(test (eval (parse '(fun (x) (* a x))) (aEnv 'a (numV 3) (mtEnv)))
      (closureV (list 'x) (parse '(* a x)) (aEnv 'a (numV 3) (mtEnv))))
(test (eval (parse '(fun (p q r) (+ (- t p) (*q r)))) (aEnv 't (numV 5) (mtEnv)))
      (closureV (list 'p 'q 'r) (parse '(+ (- t p) (*q r))) (aEnv 't (numV 5) (mtEnv))))
;; app
(test (eval (parse '(sum 1 2)) (aEnv 'sum (closureV (list 'x 'y) (add (id 'x) (id 'y)) (mtEnv)) (mtEnv)))
      (numV 3))
(test (eval (parse '(has_static_scope)) (aEnv 'has_static_scope (closureV (list) (id 'a) (aEnv 'a (boolV #t) (mtEnv)))
                                              (aEnv 'a (boolV #f) (mtEnv))))
      (boolV #t))
(test (eval (parse '(sqr i)) (aEnv 'sqr (closureV (list 'x) (mul (id 'x) (id 'x)) (mtEnv))
                                   (aEnv 'i (numV 12) (mtEnv))))
      (numV 144))


#| Tests Parte 1F |#
;; parse tests
;; tuple
(test (parse '(tuple)) (tupl (list)))
(test (parse '(tuple 1)) (tupl (list (num 1))))
(test (parse '(tuple 1 a 2 b)) (tupl (list (num 1) (id 'a) (num 2) (id 'b))))
(test (parse '(tuple (+ 7 x))) (tupl (list (add (num 7) (id 'x)))))
;; proj
(test (parse '(proj (tuple 1 2) 0)) (proj (tupl (list (num 1) (num 2))) (num 0)))
(test (parse '(proj (tuple 4) i)) (proj (tupl (list (num 4))) (id 'i)))
(test (parse '(proj (tuple 1 1 1) (+ 1 1))) (proj (tupl (list (num 1) (num 1) (num 1))) (add (num 1) (num 1))))


#| Tests Parte 1G |#
;; eval tests
;; tuple
(test (eval (parse '(tuple)) (mtEnv)) (tupleV (list)))
(test (eval (parse '(tuple 1 #t 3)) (mtEnv)) (tupleV (list (numV 1) (boolV #t) (numV 3))))
(test (eval (parse '(tuple x y)) (aEnv 'x (numV 0) (aEnv 'y (boolV #f) (mtEnv)))) (tupleV (list (numV 0) (boolV #f))))
(test (eval (parse '(tuple (+ 1 2))) (mtEnv)) (tupleV (list (numV 3))))
(test (eval (parse '(tuple (verdad))) (aEnv 'verdad (closureV (list) (tt) (mtEnv)) (mtEnv))) (tupleV (list (boolV #t))))
;; proj
(test (eval (parse '(proj (tuple 1 2) 0)) (mtEnv)) (numV 1))
(test (eval (parse '(proj (tuple (+ 1 2) (+ 3 4)) 0)) (mtEnv)) (numV 3))
(test (eval (parse '(proj (tuple 4 5 6) (+ 1 1))) (mtEnv)) (numV 6))
(test (eval (parse '(proj (tuple 10 20 30) i)) (aEnv 'i (numV 1) (mtEnv))) (numV 20))
(test (eval (parse '(proj (tuple 123 456 789) (sqr 1))) (aEnv 'sqr (closureV (list 'x) (mul (id 'x) (id 'x)) (mtEnv)) (mtEnv))) (numV 456))



#| Tests Parte 2 |#
;; inject-functions tests
(define id* (closureV (list 'x) (parse 'x) empty-env))
(test (inject-functions '() empty-env) (empty-env))
(test (inject-functions (list (cons 'id id*) (cons 'swap swap*)) empty-env) (aEnv 'swap swap* (aEnv 'id id* empty-env)))
