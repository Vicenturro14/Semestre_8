#lang play
(print-only-errors)

;; PARTE 1A, 1B, 1F

#|
  <Expr> ::= (num <num>)
           | (add <Expr> <Expr>)
           | (sub <Expr> <Expr>)
           | (mul <Expr> <Expr>)
           | (tt)
           | (ff)
           | (leq <Expr> <Expr>
           | (ifc <Expr> <Expr> <Expr>)
           | (id <sym>)
           | (fun ListOf[<sym>] <Expr>)
           | (app <Expr> ListOf[<Expr>])
|#
;; Tipo inductivo para representar funciones, llamadas a funciones, identificadores
;; y expresiones aritméticas y lógicas.
(deftype Expr
  ;; core
  (num n)
  (id x)
  (add l r)
  (sub l r)
  (mul l r)
  (tt)
  (ff)
  (leq l r)
  (ifc c t f)
  (fun params body)
  (app fname args)
  )

;; parse :: s-expr -> Expr
;; Convierte s-expr a su equivalente en Expr.
(define (parse s_expr)
  (match s_expr
    [n #:when (number? n) (num n)]
    [x #:when (symbol? x) (id x)]
    [(list '+ l r) (add (parse l) (parse r))]
    [(list '- l r) (sub (parse l) (parse r))]
    [(list '* l r) (mul (parse l) (parse r))]
    [#t (tt)]
    [#f (ff)]
    [(list '<= l r) (leq (parse l) (parse r))]
    [(list 'if c t f) (ifc (parse c) (parse t) (parse f))]
    [(list 'fun (list params ...) expr) (fun params (parse expr))]
    [(list fname args ...) #:when (symbol? fname) (app (id fname) (map parse args))]
    )
  )



;; PARTE 1C, 1G

#|
<Val>  ::= (numV <num>)
         | (closureV <sym> <Expr> <Env>)
|#
;; Tipo que representa el valor de las expresiones
(deftype Val
  (numV n)
  (closureV id body env)
  )

;; ambiente de sustitución diferida
(deftype Env
  (mtEnv)
  (aEnv id val env))

;; interface ADT (abstract data type) del ambiente
(define empty-env (mtEnv))

;; "Simplemente" asigna un nuevo identificador para aEnv
;(define extend-env aEnv)
;;
;; es lo mismo que definir extend-env así:
;; (concepto técnico 'eta expansion')
(define (extend-env id val env) (aEnv id val env))

(define (env-lookup x env)
  (match env
    [(mtEnv) (error 'env-lookup "free identifier: ~a" x)]
    [(aEnv id val rest) (if (symbol=? id x) val (env-lookup x rest))]))



;; PARTE 1D

;; num2num-op :: ...
(define (num2num-op) '???)

;; num2bool-op :: ...
(define (num2bool-op) '???)



;; PARTE 1E, 1G

;; eval :: ...
(define (eval) '???)



;; PARTE 2A

(define swap* '???)
(define curry* '???)
(define uncurry* '???)
(define partial* '???)



;; PARTE 2B

;; run :: ...
(define (run) '???)
