#lang play
#| Nombre: Vicente Olivares |#

#| P1 |#

#| Parte A |#

#|
<Prop> ::= (varp <String>)
         | (andp <Prop> <Prop>)
         | (orp <Prop> <Prop>)
         | (notp <Prop>)
|#
;; Tipo inductivo para representar preposiciones lógicas.
(deftype Prop
  (varp n)
  (andp p q)
  (orp p q)
  (notp p))



#| Parte B |#

;; occurrences :: Prop String -> Number
;; Retorna la cantidad de veces que aparece la variable recibida en la propocición lógica recibida.

(define (occurrences prop var)
  (match prop
    [(varp n)
     (if (equal? n var)
         1
         0)]
    [(andp p q) (+ (occurrences p var) (occurrences q var))]
    [(orp p q) (+ (occurrences p var) (occurrences q var))]
    [(notp p) (occurrences p var)]))



#| Parte C |#

;; vars-rep :: Prop -> (Listof String)
;; Retorna una lista de las variables dentro de la proposición lógica entregada con duplicados, en caso de existir.
(define (vars-rep prop)
  (match prop
    [(varp n) (list n)]
    [(andp p q) (append (vars-rep p) (vars-rep q))]
    [(orp p q) (append (vars-rep p) (vars-rep q))]
    [(notp p) (vars-rep p)]))

;; vars :: Prop -> (Listof String)
;; Retorna una lista sin duplicados de las variables dentro de la proposición lógica entregada.
(define (vars prop)
  (remove-duplicates (vars-rep prop)))



#| Parte D |#

;; add-var-to-env :: String (Listof (Pair String Boolean)) -> (Listof (Listof (Pair String Boolean)))
;; Agrega la variable recibida al ambiente recibido, retornando una lista con los ambientes resultantes.
;; Se asume que no se entregarán variables ya existentes en el ambiente.
(define (add-var-to-env var env)
  (list (append env (list (cons var #t)))
        (append env (list (cons var #f)))))


;; add-var-to-env-list :: String (Listof (Listof (Pair String Boolean))) -> (Listof (Listof (Pair String Boolean)))
;; Agrega la variable recibida a cada ambiente de la lista de ambientes recibida, retornando una lista con los ambientes resultantes.
;; Se asume que no se intentarán agregar variables que ya están en los ambientes de la lista recibida.
(define (add-var-to-env-list var env-list)
  (match env-list
    ['() '()]
    [(cons env rest) (append (add-var-to-env var env) (add-var-to-env-list var rest))]))


;; add-var-list-to-env-list :: (Listof String) (Listof (Listof (Pair String Boolean))) -> (Listof (Listof (Pair String Boolean)))
;; Agrega las variables de la lista recibida a la lista de ambientes recibida, retornando una lista con los ambientes resultantes.
(define (add-var-list-to-env-list var-list env-list)
  (match var-list
    ['() env-list]
    [(cons var rest) (add-var-list-to-env-list rest (add-var-to-env-list var env-list))]))


;; all-environments :: (Listof String) -> (Listof (Listof (Pair String Boolean)))
;; Retorna una lista con todos los ambientes de evaluasión posibles de las variables de la lista entregada.
(define (all-environments var-list)
  (add-var-list-to-env-list var-list (list (list)))) 



#| Parte E |#

;; eval :: Prop (Listof (Pair String Boolean)) -> Boolean
;; Retorna el resultado de la proposición recibida evaluada con los valores del ambiente recibido.
;; Si el nombre de alguna variable de la proposición no se encuentra en el ambiente recibido, se arroja un error.
(define (eval prop env)
  (match prop
    [(varp n) (let ([value (assoc n env)]) 
                (if (value)
                    (cdr value)
                    (error (format "eval: variable ~a is not defined in environment" n))))]
    [(andp p q) (let ([p-value (eval p env)]
                      [q-value (eval q env)])
                  (and p-value q-value))]
    [(orp p q) (let ([p-value (eval p env)]
                     [q-value (eval q env)])
                 (or p-value q-value))]
    [(notp p) (not (eval p env))]))


#| Parte F |#

;; tautology? :: Prop -> Boolean



#| P2 |#

#| Parte A |#

;; simplify-negations :: Prop -> Prop

#| Parte B |#

;; distribute-and :: Prop -> Prop

#| Parte C |#

;; apply-until :: (a -> a) (a a -> Boolean) -> a -> a

#| Parte D |#

;; DNF :: Prop -> Prop



#| P3 |#

#| Parte A |#

;; fold-prop :: (String -> a) (a a -> a) (a a -> a) (a -> a) -> Prop -> a

#| Parte B |#

;; occurrences-2 :: Prop String -> Number

;; vars-2 :: Prop -> (Listof String)

;; eval-2 :: Prop (Listof (Pair String Boolean)) -> Boolean

;; simplify-negations-2 :: Prop -> Prop

;; distribute-and-2 :: Prop -> Prop
