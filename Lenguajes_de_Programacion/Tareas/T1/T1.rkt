#lang play

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

;; all-environments :: (Listof String) -> (Listof (Listof (Pair String Boolean)))
;; Retorna una lista con todos los ambientes de evaluasión posibles de las variables de la lista entregada.
(define (all-environments var-list)
  (match varlist
    ['() (list (list))]
    [
    

#| Parte E |#

;; eval :: Prop (Listof (Pair String Boolean)) -> Boolean

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
