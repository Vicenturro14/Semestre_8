#lang play
(print-only-errors)

;; PARTE 1A, 1B, 1F

#|
  <Expr> ::= (num <num>)
           | (id <sym>)
           | (add <Expr> <Expr>)
           | (sub <Expr> <Expr>)
           | (mul <Expr> <Expr>)
           | (tt)
           | (ff)
           | (leq <Expr> <Expr>
           | (ifc <Expr> <Expr> <Expr>)
           | (fun ListOf[<sym>] <Expr>)
           | (app <Expr> ListOf[<Expr>])
           | (tupl ListOf[<Expr>])
           | (proj <Expr> <Expr>)
|#
;; Tipo inductivo para representar funciones, llamadas a funciones, identificadores,
;; tuplas, proyecciones de tuplas y expresiones aritméticas y lógicas.
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
  (tupl expr_list)
  (proj tuple index)
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
    [(list 'tuple elems ...) (tupl (map parse elems))]
    [(list 'proj tup index) (proj (parse tup) (parse index))]
    [(list fname args ...) #:when (symbol? fname) (app (id fname) (map parse args))]
    )
  )



;; PARTE 1C, 1G

#|
<Val>  ::= (numV <num>)
         | (boolV <Boolean>)
         | (closureV ListOf[<sym>] <Expr> <Env>)
         | (tupleV ListOf[<Val>])
|#
;; Tipo que representa el valor de las expresiones
(deftype Val
  (numV n)
  (boolV b)
  (closureV params body env)
  (tupleV value_list)
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

;; num2num-op :: (Number Number -> Number) -> (Val Val -> Val)
;; Recibe una función que opera sobre dos números resultando un número,
;; y retorna la función equivalente a la función recibida pero que opera y retorna elementos de tipo Val. 
(define (num2num-op num_f)
  (λ (v1 v2)
    (if (and (numV? v1) (numV? v2))
        (numV (num_f (numV-n v1) (numV-n v2)))
        (error "num-op: invalid operands"))))

;; num+ :: Val Val -> Val
;; Retorna la suma de los valores recibidos.
(define num+ (num2num-op +))

;; num- :: Val Val -> Val
;; Retorna la resta de los valores recibidos.
(define num- (num2num-op -))

;; num* :: Val Val -> Val
;; Retorna el producto de los valores recibidos.
(define num* (num2num-op *))


;; num2bool-op :: (Number Number -> Boolean) -> (Val Val -> Val)
;; Retorna la función equivalente al predicado recibido pero esta opera y retorna elementos de tipo Val.
(define (num2bool-op num_f)
  (λ (v1 v2)
    (if (and (numV? v1) (numV? v2))
        (boolV (num_f (numV-n v1) (numV-n v2)))
        (error "num-op: invalid operands"))))

;; num<= :: Val Val -> Val
;; Retorna un boolV indicando si el primer elemento tipo Val recibido
;; es menor o igual al segundo elemento tipo Val recibido.
(define num<= (num2bool-op <=))



;; PARTE 1E, 1G

;; multi-extend-env :: ListOf[sym] ListOf[Val] Env -> Env
;; Extiende el ambiente recibido con varios identicadores.
;; Se asocia el i-ésimo identificador con el i-ésimo valor de las listas recibidas.
(define (multi-extend-env id_list val_list env)
  (foldl extend-env env id_list val_list)) 

;; eval :: Expr Env -> Val
;; Evalua la expresión recibida con el entorno recibido.
(define (eval expr env)
  (match expr
    [(num n) (numV n)]
    [(id x) (env-lookup x env)]
    [(add l r) (num+ (eval l env) (eval r env))]
    [(sub l r) (num- (eval l env) (eval r env))]
    [(mul l r) (num* (eval l env) (eval r env))]
    [(tt) (boolV #t)]
    [(ff) (boolV #f)]
    [(leq l r) (num<= (eval l env) (eval r env))]
    [(ifc c t f) (if (boolV-b (eval c env))
                     (eval t env)
                     (eval f env))]
    [(fun params body) (closureV params body env)]
    [(app fname fargs) (def (closureV fparams fbody fenv) (eval fname env))
                       (def extended_env (multi-extend-env fparams (map (λ (e) (eval e env)) fargs) fenv))
                       (eval fbody extended_env)]
    [(tupl expr_list) (tupleV (map (λ (e) (eval e env)) expr_list))]
    [(proj (tupl expr_list) index) (def (numV i) (eval index env))
                                   (eval (list-ref expr_list i) env)]
    )
  )



;; PARTE 2A

;; swap* :: (a b -> c) -> (b a -> c)
;; Recibe una función f de dos argumentos y retorna una función que recibe los argumentos en orden inverso a f.

(define swap*
  (closureV (list 'f) (parse '(fun (y x) (f x y))) empty-env)
  )

;; curry* :: (a b -> c) -> (a -> b -> c)
;; Recibe una función de dos argumentos y retorna su versión currificada.
(define curry*
  (closureV (list 'f) (parse '(fun (x) (fun (y) (f x y)))) empty-env)
  )
;; uncurry* :: (a -> b -> c) -> (a b -> c)
;; Recibe una función currificada y retorna su versión currificada de dos argumentos.
(define uncurry*
  (closureV (list 'f) (parse '(fun (x y) ((f x) y))) empty-env)
  )

;; partial* :: (a b -> c) a -> (b -> c)
;; Recibe una función f de dos argumentos y un argumento x, y retorna la función resultante de aplicar parcialmente f con x. 
(define partial*
  (closureV (list 'f 'x) (parse '(fun (y) (f x y))) empty-env)
  )



;; PARTE 2B

;; inject-functions :: ListOf[(Pair sym Val)] env -> env
;; Inyecta las funciones de la lista recibida en el entorno recibido.
(define (inject-functions funs env)
  (match funs
    ['() env]
    [(cons (cons fname fclosure) rest) (inject-functions rest (extend-env fname fclosure env))]))

;; run :: s-expr ListOf[(Pair sym Val)] -> Val
(define (run) '???)
