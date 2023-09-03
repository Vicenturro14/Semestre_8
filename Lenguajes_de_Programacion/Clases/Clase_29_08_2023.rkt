#lang play
(with (x (+ 5 5)) (with ( y (- 3 x )) (+ y (+ x z))))
;; x en with (x (+ 5 5)) es una binding occurrence (ocurrencia ligante?/enlazante?)
;; x en with (y (- 3 x)) es una bound occurrence (occurrencia ligada?/enlazada?)
;; z en toda la expresión es una free occurrence (ocurrencia libre)

;; Una expresión abierta es una expresión con al menos una ocurrencia libre
;; Una expresión cerrada es una expresión sin ocurrencias libres

;; Colisión de alcances




( with (id named-expr) body)
;; id es reemplazada en body en las ocurrencias libres y no en las ligadas
