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

#| Parte C |#

;; vars :: Prop -> (Listof String)

#| Parte D |#

;; all-environments :: (Listof String) -> (Listof (Listof (Pair String Boolean)))

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
