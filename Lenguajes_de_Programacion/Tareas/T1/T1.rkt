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
    [(varp n) (if (equal? n var)
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
                (if value
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

;; multi-env-eval :: Prop (Listof (Listof (Pair String Boolean))) -> Boolean
;; Evalua la proposición recibida en todos los ambientes de la lista recibida.
;; Retorna #t si el resultado de la evaluación de la proposición es #t en todos los ambientes, en caso contrario retorna #f.
(define (multi-env-eval prop env-list)
  (match env-list
    ['() #t]
    [(cons env rest) (if (eval prop env)
                         (multi-env-eval prop rest)
                         #f)]))

;; tautology? :: Prop -> Boolean
;; Retorna #t si la proposición recibida es una tautología.
(define (tautology? prop)
  (multi-env-eval prop (all-environments (vars prop))))
  



#| P2 |#

#| Parte A |#

;; simplify-negations :: Prop -> Prop
;; Realiza una pasada de simplificación de negaciones de la proposición recibida eliminando dobles negaciones y aplicando leyes de Morgan.
;; Es posible que alguna simplificación genere una nueva negación sin simplificar.
(define (simplify-negations prop)
  (match prop
    [(varp n) (varp n)]
    [(andp p q) (andp (simplify-negations p) (simplify-negations q))]
    [(orp p q) (orp (simplify-negations p) (simplify-negations q))]
    [(notp (notp p)) (simplify-negations p)]
    [(notp (andp p q)) (orp (notp (simplify-negations p)) (notp (simplify-negations q)))]
    [(notp (orp p q)) (andp (notp (simplify-negations p)) (notp (simplify-negations q)))]
    [(notp (varp n)) (notp (varp n))]))



#| Parte B |#

;; distribute-and :: Prop -> Prop
;; Distribuye las conjunciónes de la proposición recibida siguiendo las leyes de distribución correspondientes.
;; Es posible que alguna distribución genere una nueva conjunción sin distribuir.
(define (distribute-and prop)
  (match prop
    [(varp n) (varp n)]
    [(andp (orp p q) r) (orp (andp (distribute-and p) (distribute-and r)) (andp (distribute-and q) (distribute-and r)))]
    [(andp p (orp q r)) (orp (andp (distribute-and p) (distribute-and q)) (andp (distribute-and p) (distribute-and r)))]
    [(andp p q) (andp (distribute-and p) (distribute-and q))]
    [(orp p q) (orp (distribute-and p) (distribute-and q))]
    [(notp p) (notp (distribute-and p))]))



#| Parte C |#

;; apply-until :: (a -> a) (a a -> Boolean) -> a -> a
;; Retorna una función que recibe un parámetro x. Esta aplica la función f recibida a x hasta que el predicado entregado evaluado en x y el resultado de aplicar f sobre x retorne #t. 
(define (apply-until f pred)
  (λ (x) (let ([new-x (f x)])
           (if (pred x new-x)
             new-x
             ((apply-until f pred) new-x)))))



#| Parte D |#
;; simplify-all-negations :: Prop -> Prop
;; Simplifica totalmente lasnegaciones de la proposición recibida eliminando dobles negaciones y aplicando leyes de Morgan.
(define (simplify-all-negations prop)
  ((apply-until simplify-negations equal?) prop))

;; distribute-all-and ;; Prop -> Prop
;; Distribuye todas las conjunciones de la proposición recibida siguiendo las leyes de distribución correspondientes.
(define (distribute-all-and prop)
  ((apply-until distribute-and equal?) prop))

;; DNF :: Prop -> Prop
;; Retorna la forma normal disyuntiva de la proposición lógica recibida.
(define (DNF prop)
  (distribute-all-and (simplify-all-negations prop)))
       



#| P3 |#

#| Parte A |#

;; fold-prop :: (String -> a) (a a -> a) (a a -> a) (a -> a) -> Prop -> a
;; Retorna una función recursiva sobre el tipo inductivo Prop según las funciones que se reciban para los constructores varp, andp, orp y notp.
(define (fold-prop varp-f andp-f orp-f notp-f)
  (λ (prop)
    (match prop
      [(varp n) (varp-f n)]
      [(andp p q) (andp-f ((fold-prop varp-f andp-f orp-f notp-f) p)
                          ((fold-prop varp-f andp-f orp-f notp-f) q))]                   
      [(orp p q) (orp-f ((fold-prop varp-f andp-f orp-f notp-f) p)
                        ((fold-prop varp-f andp-f orp-f notp-f) q))]      
      [(notp p) (notp-f ((fold-prop varp-f andp-f orp-f notp-f) p))])))

#| Parte B |#

;; occurrences-2 :: Prop String -> Number
;; Retorna la cantidad de veces que aparece la variable recibida en la propocición lógica recibida.
(define (occurrences-2 prop var)
  ((fold-prop (λ (n) (if (equal? n var) 1 0))
              (λ (p q) (+ p q))
              (λ (p q) (+ p q))
              (λ (p) p))
   prop))
   

;; vars-2 :: Prop -> (Listof String)
;; Retorna una lista sin duplicados de las variables dentro de la proposición lógica entregada.
(define (vars-2 prop)
  (remove-duplicates ((fold-prop list
                                append
                                append
                                (λ (p) p))
                      prop)))



;; eval-2 :: Prop (Listof (Pair String Boolean)) -> Boolean

#|
;; eval :: Prop (Listof (Pair String Boolean)) -> Boolean
;; Retorna el resultado de la proposición recibida evaluada con los valores del ambiente recibido.
;; Si el nombre de alguna variable de la proposición no se encuentra en el ambiente recibido, se arroja un error.
(define (eval prop env)
  (match prop
    [(varp n) (let ([value (assoc n env)]) 
                (if value
                    (cdr value)
                    (error (format "eval: variable ~a is not defined in environment" n))))]
    [(andp p q) (let ([p-value (eval p env)]
                      [q-value (eval q env)])
                  (and p-value q-value))]
    [(orp p q) (let ([p-value (eval p env)]
                     [q-value (eval q env)])
                 (or p-value q-value))]
    [(notp p) (not (eval p env))]))
|#



;; simplify-negations-2 :: Prop -> Prop

#|
;; simplify-negations :: Prop -> Prop
;; Realiza una pasada de simplificación de negaciones de la proposición recibida eliminando dobles negaciones y aplicando leyes de Morgan.
;; Es posible que alguna simplificación genere una nueva negación sin simplificar.
(define (simplify-negations prop)
  (match prop
    [(varp n) (varp n)]
    [(andp p q) (andp (simplify-negations p) (simplify-negations q))]
    [(orp p q) (orp (simplify-negations p) (simplify-negations q))]
    [(notp (notp p)) (simplify-negations p)]
    [(notp (andp p q)) (orp (notp (simplify-negations p)) (notp (simplify-negations q)))]
    [(notp (orp p q)) (andp (notp (simplify-negations p)) (notp (simplify-negations q)))]
    [(notp (varp n)) (notp (varp n))]))
|#



;; distribute-and-2 :: Prop -> Prop

#|
;; distribute-and :: Prop -> Prop
;; Distribuye las conjunciónes de la proposición recibida siguiendo las leyes de distribución correspondientes.
;; Es posible que alguna distribución genere una nueva conjunción sin distribuir.
(define (distribute-and prop)
  (match prop
    [(varp n) (varp n)]
    [(andp (orp p q) r) (orp (andp (distribute-and p) (distribute-and r)) (andp (distribute-and q) (distribute-and r)))]
    [(andp p (orp q r)) (orp (andp (distribute-and p) (distribute-and q)) (andp (distribute-and p) (distribute-and r)))]
    [(andp p q) (andp (distribute-and p) (distribute-and q))]
    [(orp p q) (orp (distribute-and p) (distribute-and q))]
    [(notp p) (notp (distribute-and p))]))
|#

