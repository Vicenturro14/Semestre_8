#lang play
(require "T3.rkt")
; Estudiante: Vicente Olivares Gómez

(print-only-errors #t)
#| Tests Parte 1A |#
;; parse-type tests
(test (parse-type 'Number) (numT))
(test (parse-type '(-> Number Number)) (arrowT (numT) (numT)))
(test (parse-type '(-> Number (-> Number Number))) (arrowT (numT) (arrowT (numT) (numT))))
(test (parse-type '(-> (-> Number Number) Number)) (arrowT (arrowT (numT) (numT)) (numT)))



#| Tests Parte 1B |#
;; infer-type tests
;; Literal numérico
(test (infer-type (num 4) empty-tenv) (numT))

;; Adición
(test (infer-type (binop '+ (num 1) (num 2)) empty-tenv) (numT))
(test (infer-type (binop '+ (binop '+ (num 46) (num 38)) (binop '+ (num 2) (num 6))) empty-tenv) (numT))
(test/exn (infer-type (binop '+ (num 17) (fun 'x (numT) (id 'x))) empty-tenv) "infer-type: invalid operand type for +")
(test/exn (infer-type (binop '+ (fun 'x (numT) (id 'x)) (num 6)) empty-tenv) "infer-type: invalid operand type for +")
(test/exn (infer-type (binop '+ (fun 'z (numT) (id 'z)) (fun 'x (numT) (id 'x))) empty-tenv) "infer-type: invalid operand type for +")

;; Resta
(test (infer-type (binop '- (num 3) (num 4)) empty-tenv) (numT))
(test (infer-type (binop '- (binop '+ (num 86) (num 363)) (binop '- (num 1) (num 3))) empty-tenv) (numT))
(test/exn (infer-type (binop '- (num 8) (fun 'x (numT) (id 'x))) empty-tenv) "infer-type: invalid operand type for -")
(test/exn (infer-type (binop '- (fun 'x (numT) (id 'x)) (num 0)) empty-tenv) "infer-type: invalid operand type for -")
(test/exn (infer-type (binop '- (fun 'a (numT) (id 'a)) (fun 'x (numT) (id 'x))) empty-tenv) "infer-type: invalid operand type for -")

;; Multiplicación
(test (infer-type (binop '* (num 5) (num 6)) empty-tenv) (numT))
(test (infer-type (binop '* (binop '- (num 53) (num 51)) (binop '+ (num 4) (num 6))) empty-tenv) (numT))
(test/exn (infer-type (binop '* (num 53) (fun 'x (numT) (id 'x))) empty-tenv) "infer-type: invalid operand type for *")
(test/exn (infer-type (binop '* (fun 'x (numT) (id 'x)) (num 44)) empty-tenv) "infer-type: invalid operand type for *")
(test/exn (infer-type (binop '* (fun 'x (numT) (id 'x)) (fun 'b (numT) (id 'b))) empty-tenv) "infer-type: invalid operand type for *")

;; Identificador
(test (infer-type (id 'x) (aTenv 'x (numT) empty-tenv)) (numT))
(test (infer-type (id 'f) (aTenv 'f (arrowT (numT) (numT)) empty-tenv)) (arrowT (numT) (numT)))

;; Función
(test (infer-type (fun 'x (numT) (id 'x)) empty-tenv) (arrowT (numT) (numT)))
(test (infer-type (fun 'g (arrowT (numT) (numT)) (num 0)) empty-env) (arrowT (arrowT (numT) (numT)) (numT)))
(test (infer-type (fun 'f (arrowT (numT) (numT)) (id 'f)) empty-env) (arrowT (arrowT (numT) (numT)) (arrowT (numT) (numT))))

;; Aplicación
(test (infer-type (app (fun 'x (numT) (id 'x)) (num 1)) empty-env) (numT))
(test (infer-type (app (fun 'c (arrowT (numT) (numT)) (num 4)) (fun 'x (numT) (id 'x))) empty-env) (numT))
(test (infer-type (app (fun 'f (arrowT (numT) (numT)) (id 'f)) (fun 'x (numT) (id 'x))) empty-env) (arrowT (numT) (numT)))
(test/exn (infer-type (app (num 3) (num 0)) empty-env) "infer-type: function application to a non-function")
(test/exn (infer-type (app (fun 'x (numT) (id 'x)) (fun 'a (numT) (num 22))) empty-env) "infer-type: function argument type mismatch")
(test/exn (infer-type (app (fun 'f (arrowT (numT) (numT)) (id 'f)) (num 42)) empty-env) "infer-type: function argument type mismatch")



#| Tests Parte 1C |#
;; parse-type tests
(test (parse-type 'Boolean) (boolT))
(test (parse-type '(-> Boolean Number)) (arrowT (boolT) (numT)))

;; parse tests
;; Valores booleanos
(test (parse 'true) (tt))
(test (parse 'false) (ff))

;; menor o igual
(test (parse '(<= 1 2)) (binop '<= (num 1) (num 2)))
(test (parse '(<= (+ 4 2) (* 245 0))) (binop '<= (binop '+ (num 4) (num 2)) (binop '* (num 245) (num 0))))

;; if
(test (parse '(if true 1 2)) (ifc (tt) (num 1) (num 2)))
(test (parse '(if (<= 4 44) (+ 3 3) (- 3 3))) (ifc (binop '<= (num 4) (num 44)) (binop '+ (num 3) (num 3)) (binop '- (num 3) (num 3))))

;; infer-type tests
;; Literal booleano
(test (infer-type (tt) empty-tenv) (boolT))
(test (infer-type (ff) empty-tenv) (boolT))
(test (infer-type (id 'b) (aTenv 'b (boolT) empty-tenv)) (boolT))

;; Menor o igual
(test (infer-type (parse '(<= 11 22)) empty-tenv) (boolT))
(test (infer-type (parse '(<= (+ 5 2) c)) (aTenv 'c (numT) empty-tenv)) (boolT))
(test/exn (infer-type (parse '(<= true 1)) empty-tenv) "infer-type: invalid operand type for <=")
(test/exn (infer-type (parse '(<= 0 false)) empty-tenv) "infer-type: invalid operand type for <=")
(test/exn (infer-type (parse '(<= (fun (x : Boolean) 2) 1)) empty-tenv) "infer-type: invalid operand type for <=")

;; if
(test (infer-type (parse '(if true 1 3)) empty-tenv) (numT))
(test (infer-type (parse '(if false true false)) empty-tenv) (boolT))
(test (infer-type (parse '(if (<= 1 2) 4 6)) empty-tenv) (numT))
(test (infer-type (parse '(if c t 2)) (aTenv 'c (boolT) (aTenv 't (numT) empty-tenv))) (numT))
(test/exn (infer-type (parse '(if 4 2 4)) empty-tenv) "infer-type: if condition must be a boolean")
(test/exn (infer-type (parse '(if true 4 false)) empty-tenv) "infer-type: if branches type mismatch")
(test/exn (infer-type (parse '(if true true (fun (x : Number) 1))) empty-tenv) "infer-type: if branches type mismatch")
(test/exn (infer-type (parse '(if true 4 (fun (b : Boolean) 4))) empty-tenv) "infer-type: if branches type mismatch")



#| Tests Parte 2A |#
;; final? tests
(test (final? (num 4)) #t)
(test (final? (fun 'x (numT) (num 0))) #t)
(test (final? (binop '+ (num 3) (num 4))) #f)
(test (final? (binop '- (num 1) (num 8))) #f)
(test (final? (binop '* (num 99) (num 0))) #f)
(test (final? (id 'x)) #f)
(test (final? (app (fun 'x (numT) (num 0)) (num 4))) #f)



#| Tests Parte 2D |#
;; inject tests
(test (inject (num 4)) (st (num 4) empty-env empty-kont))
(test (inject (binop '+ (num 1) (num 2))) (st (binop '+ (num 1) (num 2)) empty-env empty-kont))
(test (inject (id 'a)) (st (id 'a) empty-env empty-kont))
(test (inject (fun 'x (numT) (id 'x))) (st (fun 'x (numT) (id 'x)) empty-env empty-kont))
(test (inject (app (fun 'x (numT) (id 'x)) (num 6))) (st (app (fun 'x (numT) (id 'x)) (num 6)) empty-env empty-kont))

#| Tests Parte 2E |#
;; step tests
;; RLEFT
(test (step (st (parse '(+ 3 5)) empty-env empty-kont)) (st (num 3) empty-env (binop-r-k '+ (num 5) empty-env empty-kont)))
(test (step (st (parse '(* (- 1 4) 5)) empty-env empty-kont)) (st (parse '(- 1 4)) empty-env (binop-r-k '* (num 5) empty-env empty-kont)))

;; RVAR
(test (step (st (id 'x) (aEnv 'x (cons (num 0) empty-env) empty-env) empty-kont)) (st (num 0) empty-env empty-kont))
(test (step (st (id 'a) (aEnv 'x (cons (num 0) empty-env) (aEnv 'a (cons (num 1) empty-env) empty-env)) empty-kont))
      (st (num 1) empty-env empty-kont))
(test (step (st (id 'x) (aEnv 'x (cons (num 0) (aEnv 'a (cons (num 1) empty-env) empty-env)) empty-env) empty-kont))
      (st (num 0) (aEnv 'a (cons (num 1) empty-env) empty-env) empty-kont))

;; RFUN
(test (step (st (app (fun 'x (numT) (num 77)) (num 1)) empty-env empty-kont)) (st (fun 'x (numT) (num 77)) empty-env (arg-k (num 1) empty-env empty-kont)))

;; RRIGHT
(test (step (st (num 3) empty-env (binop-r-k '+ (num 5) empty-env empty-kont))) (st (num 5) empty-env (binop-l-k '+ (num 3) empty-env empty-kont)))
(test (step (st (num -3) empty-env (binop-r-k '* (num 5) (extend-env 'a (cons (num 35) empty-env) empty-env) empty-kont)))
      (st (num 5) (extend-env 'a (cons (num 35) empty-env) empty-env) (binop-l-k '* (num -3) empty-env empty-kont)))

;;RBINOP
(test (step (st (num 5) empty-env (binop-l-k '+ (num 3) empty-env empty-kont))) (st (num 8) empty-env empty-kont))
(test (step (st (num 5) (extend-env 'a (cons (num 35) empty-env) empty-env) (binop-l-k '* (num -3) empty-env empty-kont)))
      (st (num -15) (extend-env 'a (cons (num 35) empty-env) empty-env) empty-kont))

;;RARG
(test (step (st (fun 'x (numT) (num 77)) (extend-env 'a (cons (num 35) empty-env) empty-env) (arg-k (num 1) empty-env empty-kont)))
      (st (num 1) empty-env (fun-k (fun 'x (numT) (num 77)) (extend-env 'a (cons (num 35) empty-env) empty-env) empty-kont)))

;;RAPP
(test (step (st (num 1) (extend-env 'a (cons (num 35) empty-env) empty-env) (fun-k (fun 'x (numT) (num 77)) empty-env empty-kont)))
      (st (num 77) (extend-env 'x (cons (num 1) (extend-env 'a (cons (num 35) empty-env) empty-env)) empty-env) empty-kont))



#| Tests Parte 2F |#
;; run tests
(test (run 5) (cons (num 5) (numT)))
(test (run '(+ 1 5)) (cons (num 6) (numT)))
(test (run '(- 4 8)) (cons (num -4) (numT)))
(test (run '(* 0 325)) (cons (num 0) (numT)))
(test (run '(+ (- 2 2) (* 0 123))) (cons (num 0) (numT)))
(test (run '(fun (x : Number) x)) (cons (fun 'x (numT) (id 'x)) (arrowT (numT) (numT))))
(test (run '(fun (f : (-> Number Number)) f)) (cons (fun 'f (arrowT (numT) (numT)) (id 'f)) (arrowT (arrowT (numT) (numT)) (arrowT (numT) (numT)))))
(test (run '((fun (x : Number) x) 3)) (cons (num 3) (numT)))
(test (run '((fun (f : (-> Number Number)) f) (fun (y : Number) y))) (cons (fun 'y (numT) (id 'y)) (arrowT (numT) (numT))))