#lang play
;; Estudiante: Vicente Olivares Gómez

#|
  Expr  ::= <num>
          | 'true
          | 'false 
          | (+ <Expr> <Expr>)
          | (- <Expr> <Expr>)
          | (* <Expr> <Expr>)
          | (<= <Expr> <Expr>)          
          | <id>
          | (fun (<id> : <Type>) <Expr>)
          | (<Expr> <Expr>)
          | (if <Expr> <Expr> <Expr>)
|#
(deftype Expr
  ;; core
  (num n)
  (tt)
  (ff)
  (binop op l r)
  ;; unary first-class functions
  (id x)
  (fun binder binderType body)
  (app callee arg)
  (ifc cond t f)
  )

#| BEGIN P1 |#

#|
  Type ::= 'Number
         | 'Boolean
         | (-> <Type> <Type>)
|#
;; Tipo inductivo que representa el tipo de una expresión.
(deftype Type
  (numT)
  (boolT)  
  (arrowT paramT bodyT)
  )

;; parse-type : s-expr -> Type
;; Convierte s-expr a su equivalente en Type.
(define (parse-type t)
  (match t
    ['Number (numT)]
    ['Boolean (boolT)]
    [(list '-> t1 t2) (arrowT (parse-type t1) (parse-type t2))]
    ))

;; parse : s-expr -> Expr
(define (parse s)
  (match s
    ['true (tt)]
    ['false (ff)]
    [n #:when (number? n) (num n)]
    [x #:when (symbol? x) (id x)]
    [(list '+ l r) (binop '+ (parse l) (parse r))]
    [(list '- l r) (binop '- (parse l) (parse r))]
    [(list '* l r) (binop '* (parse l) (parse r))]
    [(list '<= l r) (binop '<= (parse l) (parse r))]
    [(list 'if cond t f) (ifc (parse cond) (parse t) (parse f))]
    [(list 'fun (list binder ': type) body) (fun binder (parse-type type) (parse body))]
    [(list callee arg) (app (parse callee) (parse arg))]
    [_ (error 'parse "invalid syntax: ~a" s)]))

;; Implementación de ambientes de tipos
;; (análoga a la de ambientes de valores)

;; TypeEnv ::= ⋅ | <TypeEnv>, <id> : <Type>
(deftype TypeEnv (mtTenv) (aTenv id type env))
(define empty-tenv (mtTenv))
(define extend-tenv aTenv)

(define (tenv-lookup x env)
  (match env
    [(mtTenv) (error 'tenv-lookup "free identifier: ~a" id)]
    [(aTenv id type rest) (if (symbol=? id x) type (tenv-lookup x rest))]
    ))

;; infer-type : Expr TypeEnv -> Type
;; Retorna el tipo Type de la expresión recibida.
;; Arroja un error en caso de haber incongruencias de tipo.
(define (infer-type expr tenv)
  (match expr
    [(num n) (numT)]
    [(binop op l r) (cond
                      [(or (not (numT? (infer-type l tenv))) (not (numT? (infer-type r tenv))))
                       (error 'infer-type "invalid operand type for ~a" op)]
                      [(equal? '<= op) (boolT)]
                      [else (numT)])]
    [(id x) (tenv-lookup x tenv)]
    [(fun param param-type body) (def new-tenv (extend-tenv param param-type tenv))
                                 (arrowT param-type (infer-type body new-tenv))]
    [(app fun_expr arg) (def fun_exprT (infer-type fun_expr tenv))
                        (def argT (infer-type arg tenv))
                        (cond
                          [(not (arrowT? fun_exprT)) (error 'infer-type "function application to a non-function")]
                          [(not (equal? (arrowT-paramT fun_exprT) argT)) (error 'infer-type "function argument type mismatch")]
                          [else (arrowT-bodyT fun_exprT)])]
    [(tt) (boolT)]
    [(ff) (boolT)]
    [(ifc c t f) (def condT (infer-type c tenv))
                    (def tT (infer-type t tenv))
                    (def fT (infer-type f tenv))
                    (cond
                      [(not (boolT? condT)) (error 'infer-type "if condition must be a boolean")]
                      [(not (equal? tT fT)) (error 'infer-type "if branches type mismatch")]
                      [else tT]
                      )]
    ))

#| END P1 |#

#| BEGIN P2 PREAMBLE |#

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

;; num2num-op : (Number Number -> Number) -> Val Val -> Val
(define (num2num-op op)
  (λ (l r)
    (match (cons l r)
      [(cons (num n) (num m)) (num (op n m))]
      [_ (error 'num-op "invalid operands")])))


(define num+ (num2num-op +))
(define num- (num2num-op -))
(define num* (num2num-op *))

#| END P2 PREAMBLE |#

#| BEGIN P2 |#

;; final? : Expr -> Boolean
;; Retorna un booleano indicando si la expresión recibida es un valor.
(define (final? e)
  (or (num? e) (fun? e))
  )

#|
  Kont ::= (mt-k)
         | (binop-r-k <Expr> <Env> <Kont>)
         | (binop-l-k <Expr> <Env> <Kont>)
         | (arg-k <Expr> <Env> <Kont>)
         | (fun-k <Expr> <Env> <Kont>)
|#
;; Tipo inductivo para representar las acciones por realizar de la máquina CEK.
(deftype Kont
  (mt-k) ; empty kont
  (binop-r-k op operand env prev-k)
  (binop-l-k op operand env prev-k)
  (arg-k fun-arg env prev-k)
  (fun-k fun env prev-k)
  )

(define empty-kont (mt-k))

;; State ::= (<Expr>, <Env>, <Kont>)
;; Tipo de dato que representa un estado de la máquina CEK.
(deftype State
  (st expr env kont)
  )

;; inject : Expr -> State
;; Retorna un estado inicial con la expresión recibida, un ambiente vacío y una continuación vacía.
(define (inject expr)
  (st expr empty-env empty-kont)
  )

;; step : State -> State
;; Ejecuta un paso de reducción al estado recibido, retornando un nuevo estado.
(define (step c)
  (match c
    ;RLEFT
    [(st (binop op l r) env kont) (st l env (binop-r-k op r env kont))]
    ;RVAR
    [(st (id x) env kont) (def (cons val val-env) (env-lookup x env))
                          (st val val-env kont)]
    ;RFUN
    [(st (app fun-expr arg) env kont) (st fun-expr env (arg-k arg env kont))]
    ;RRIGHT
    [(st l-val env (binop-r-k op r r-env kont)) (st r r-env (binop-l-k op l-val env kont))]
    ;RBINOP
    [(st r-val env (binop-l-k op l-val l-env kont)) (match op
                                                    ['+ (st (num+ l-val r-val) env kont)]
                                                    ['- (st (num- l-val r-val) env kont)]
                                                    ['* (st (num* l-val r-val) env kont)])]
    ;RARG
    [(st fun env (arg-k arg arg-env kont)) (st arg arg-env (fun-k fun env kont))]
    ;RAPP
    [(st arg-val env (fun-k (fun param _ body) fun-env kont)) (st body (extend-env param (cons arg-val env) fun-env) kont)]
    ))

;; eval : Expr -> Expr
(define (eval expr)
  (define (eval-until-final state)
    (def (st expr _ kont) state)
    (if (and (final? expr) (mt-k? kont))
        expr
        (eval-until-final (step state))))
  (eval-until-final (inject expr)))

;; run : s-expr -> (Pair Expr Type)
;; Retorna un par con el resultado de parsear y evaluar la expresión entregada, y su tipo.
(define (run s-expr)
  (def expr-result (eval (parse s-expr)))
  (def exprT (infer-type expr-result empty-tenv))
  (cons expr-result exprT)
  )
