#lang play
(print-only-errors #t) ;; Esto hace que solo se muestren los tests incorrectos al correr el programa


#|
P1.

a) La estructura cons corresponde a un par, mientras que list corresponde a una lista.
Con lo anterior, (cons 'a 'b) corresponde a un par donde el primer elemento es el símbolo 'a, y el segundo
elemento es el símbolo 'b; mientras que en (list 'a 'b) se tiene una lista donde nuevamente el primer elemento
es 'a y el segundo es 'b, pero además se tiene un elemento que está presente siempre al final de una lista,
correspondiente al elemento vacío. De esta forma, para representar (list 'a 'b) con notación de pares se
tendría que escribir como: (cons 'a (cons 'b '())), donde '() es la lista vacía.

b) Otras formas de escribir '((a b) c) son:

1. (list (list 'a 'b) 'c)  ->  al aplicar esto se obtiene '((a b) c)
2. '((a . (b . ())) . (c . ())) 
3. (cons (cons 'a (cons 'b '())) (cons 'c '()))

donde las últimas dos formas son utilizando notación de pares. Notar que cuando se usa '(...) no es necesario
utilizar ' para los símbolos, pero en los demás casos (como por ejemplo cuando se escribe (list ...)) sí se
debe utilizar.


c) Dado (define l (list '(a b c) '(d e f) '(g h i))) se tiene que:
1. Para acceder a 'c: (car (cdr (cdr (car l))))
2. Para acceder a 'e: (car (cdr (car (cdr l))))

d)
1. '(c) = (cons 'c '())
2. '(a b) = (cons 'a (cons 'b '()))
3. '((a b) (c)) = (cons (cons 'a (cons 'b '())) (cons (cons 'c '()) '()))

Notar que (cons (cons 'a 'b) (cons (cons 'c '()) '())) daría
'((a . b) (c)), pero nosotros buscamos '((a b) (c))
|#




#|
P2.
|#

;; a)
;; sums-coins :: Int Int Int -> Int
;; recibe el número de monedas de 50, 100, y 150 que se tienen, y
;; retorna la cantidad total que hay en el monedero.
(define (sums-coins m50 m100 m500)
  (+ (* m50 50)
     (+ (* m100 100)
        (* m500 500))))
#|
La operación + puede sumar 1 o más elementos a la vez, así
que también se puede definir la función como:
(define (sums-coins m50 m100 m500)
  (+ (* m50 50) (* m100 100) (* m500 500)))
|#

(test (sums-coins 1 1 1) 650)


;; b)
;; divisible? :: Int Int -> Bool
;; recibe dos números y dice si el primero es divisible
;; por el segundo.
(define (divisible? num divisor)
  (= (modulo num divisor) 0))

(test (divisible? 10 2) #t)
(test (divisible? 10 3) #f)

;; leap? :: Int -> Bool
;; recibe un año (número entero), y retorna si es o no bisiesto.
(define (leap? year)
  (if (divisible? year 4)
      (if (divisible? year 100)
          (if (divisible? year 400)
              #t
              #f)
          #t)
      #f))

(test (leap? 12) #t)
(test (leap? 100) #f)
(test (leap? 2000) #t)


;; c)
;; tax :: Num -> Num
;; recibe el sueldo bruto y retorna el impuesto a pagar.
(define (tax salary)
  (cond
    [(< salary 500000) 0]
    [(and (>= salary 500000) (< salary 750000)) (* 0.15 salary)]
    [else (* 0.28 salary)]))

(test (tax 1000) 0)
(test (tax 600000) 90000)
(test (tax 1000000) 280000)




#|
P3.
|#

;; a)
; sumatoria :: Num (Num -> Num) Num -> Num
; Aplica f a cada valor entre a y b, y retorna la suma.
(define (sumatoria a f b)
  (cond
    [(> a b) 0]
    [(+ (f a) (sumatoria (+ 1 a) f b))]))

#|
Utilizando foldl se tendría:
(define (sumatoria a f b) (foldl + 0 (map f (range a (add1 b)))))
|#

(define (addn n) (λ (x) (+ x n)))
(test (sumatoria 1 (addn 0) 5) 15)
(test (sumatoria 1 add1 5) 20)
(test (sumatoria 1 (addn 2) 5) 25)


;; b)
;; length-of-strings :: List[String] -> List[Int]
;; toma una lista de strings y retorna una lista
;; con la longitud de cada uno de estos.
(define (length-of-strings lst)
  (map string-length lst))

(test (length-of-strings '("hola" "mundo")) '(4 5))


;; c)
;; greater-than-0 :: List[Num] -> List[Num]
;; toma una lista de números y retorna otra lista con todos
;; los elementos mayores a cero que contiene la lista recibida.
(define (greater-than-0 lst)
  (define pred (λ (num) (> num 0))) ;; las funciones se tratan como valores
  (filter pred lst))

(test (greater-than-0 '(1 2 0 -4 -1)) '(1 2))




#|
P4.
|#

;; funciones auxiliares
(define (sum a b) (+ a b))
(define (res a b) (- a b))
(define curry-sum (λ (a) (λ (b) (+ a b))))
(define curry-res (λ (a) (λ (b) (- a b))))


;; a)
;; curry :: Int ((A1 A2 ... An) -> B) -> (A1 -> (... -> (An -> B)))
;; toma una función de n argumentos y retorna su versión currificada
(define (curry n f)
  ;; se hace una función auxiliar para poder pasarle un parámetro extra
  (define (curry-aux n f args) 
    (if (equal? n 0)
        (apply f (reverse args)) ;; apply aplica f a la lista
        (λ (x) (curry-aux (- n 1) f (cons x args)))))
  (curry-aux n f '()))

(test (((curry 2 sum) 1) 2) (sum 1 2))
(test (((curry 2 res) 1) 2) (res 1 2))

#|
Explicación de la función curry:

El código principal de la función se hará dentro de una función
auxiliar curry-aux, que recibe los mismos parámetros de la original pero
además tendrá una lista, la que se utilizará para almacenar los argumentos
que se han acumulado hasta el momento.

El funcionamiento de curry-aux es como sigue:

1. El caso base es cuando n es igual a 0,
en cuyo caso se tiene que todos los elementos que recibe la función f ya están disponibles,
en particular están almacenados en args, con lo que ahora solo se debe aplicar la función
f con estos argumentos.
2. En el caso en que n es mayor a 0, tenemos que aún faltan argumentos para poder aplicar la
función f, por lo que se crea una función anónima que esperará dicho argumento, y una vez recibido,
verificará si se deben recibir más o si ya se puede aplicar la función f. Para hacer esto último
se hace la recursión (curry-aux (- n 1) f (cons x args)) dentro de dicha función anónima.

Notar que cada vez que se recibe un nuevo argumento, la nueva lista args lo agregará a la cabeza,
por lo que a la hora de aplicar f con la función apply se necesita dar vuelta la lista, ya que de
otra forma se estaría haciendo (f argn ... arg2 arg1) en vez de (f arg1 arg2 ... argn). Con esto en
cuenta, la forma en que se aplicará la función es (apply f (reverse args)), donde (reverse args)
corresponde a la misma lista args pero en orden inverso, y la función apply es una función que
recibe una función f y una lista, y aplica dicha función utilizando los elementos de la lista
como argumentos.

Lo único que faltaría es, una vez completada la función auxiliar, llamarla bajo el estado inicial,
que es (curry-aux n f '()). Aquí se tiene una función f de n argumentos que no tiene ningún argumento
inicial almacenado.
|#



;; b)
;; uncurry-2 : (A -> (B -> C)) -> (A B -> C)
;; toma una función currificada con 2 argumentos y devuelve una
;; función que captura ambos argumentos al mismo tiempo.
(define (uncurry-2 f)
  (λ (x y) ((f x) y)))

(test ((uncurry-2 curry-sum) 1 2) ((curry-sum 1) 2))
(test ((uncurry-2 curry-res) 1 2) ((curry-res 1) 2))

#|
Explicación uncurry-2:

La función uncurry-2 recibe una función de dos elementos que está currificada.
Esto significa que la función toma un argumento, y retorna otra función que
espera otro elemento y ahí retorna el resultado final.

Para poder hacer que la función trabaje con dos argumentos, basta con hacer
que uncurry-2 reciba ambos argumentos al mismo tiempo, para lo cual se utilizará
una función λ que toma 2 argumentos. Una vez teniendo estos, simplemente aplicará
la función original f de la misma forma en que lo haría currificada, es decir,
((f arg1) arg2).

Con esto, lo que se obtiene finalmente es que (uncurry-2 f) será una nueva función,
la cual recibe dos argumentos y retorna un valor equivalente al haber aplicado la
función f recibiendo ambos argumentos por separado.
|#