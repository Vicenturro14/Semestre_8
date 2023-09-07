#lang play
(require "T1.rkt")
(print-only-errors #t)
#| Nombre: Vicente Olivares Gómez |#

#| Tests P1 b |#
;; Tests occurrences
(test (occurrences (varp "a") "b") 0)
(test (occurrences (varp "a") "a") 1)
(test (occurrences (notp (varp "a")) "b") 0)
(test (occurrences (notp (varp "a")) "a") 1)
(test (occurrences (andp (varp "a") (varp "b")) "c") 0)
(test (occurrences (andp (varp "a") (varp "b")) "a") 1)
(test (occurrences (andp (varp "a") (varp "a")) "a") 2)
(test (occurrences (orp (varp "a") (varp "b")) "c") 0)
(test (occurrences (orp (varp "a") (varp "b")) "a") 1)
(test (occurrences (orp (varp "a") (varp "a")) "a") 2)
(test (occurrences (orp (varp "a") (andp (varp "b") (notp (varp "c")))) "d") 0)
(test (occurrences (orp (varp "a") (andp (varp "b") (notp (varp "c")))) "a") 1)
(test (occurrences (orp (varp "a") (andp (varp "b") (notp (varp "a")))) "a") 2)
(test (occurrences (orp (varp "a") (andp (varp "a") (notp (varp "a")))) "a") 3)


#| Tests P1 c|#
;; Tests vars-rep
(test (vars-rep (varp "a")) (list "a"))
(test (vars-rep (notp (varp "a"))) (list "a"))
(test (vars-rep (andp (varp "a") (varp "b"))) (list "a" "b"))
(test (vars-rep (andp (varp "a") (varp "a"))) (list "a" "a"))
(test (vars-rep (orp (varp "a") (varp "b"))) (list "a" "b"))
(test (vars-rep (orp (varp "a") (varp "a"))) (list "a" "a"))
(test (vars-rep(orp (varp "a") (andp (varp "b") (notp (varp "c"))))) (list "a" "b" "c"))
(test (vars-rep(orp (varp "a") (andp (varp "b") (notp (varp "b"))))) (list "a" "b" "b"))
(test (vars-rep(orp (varp "c") (andp (varp "c") (notp (varp "c"))))) (list "c" "c" "c"))

;; Tests vars
(test (vars (varp "a")) (list "a"))
(test (vars (notp (varp "a"))) (list "a"))
(test (vars (andp (varp "a") (varp "b"))) (list "a" "b"))
(test (vars (andp (varp "a") (varp "a"))) (list "a"))
(test (vars (orp (varp "a") (varp "b"))) (list "a" "b"))
(test (vars (orp (varp "a") (varp "a"))) (list "a"))
(test (vars(orp (varp "a") (andp (varp "b") (notp (varp "c"))))) (list "a" "b" "c"))
(test (vars(orp (varp "a") (andp (varp "b") (notp (varp "b"))))) (list "a" "b"))
(test (vars(orp (varp "c") (andp (varp "c") (notp (varp "c"))))) (list "c"))


#| Tests P1 d |#
;; Tests add-var-to-env
(test (add-var-to-env "a" (list))
      (list (list (cons "a" #t))
            (list (cons "a" #f))))
(test (add-var-to-env "b" (list (cons "a" #t)))
      (list (list (cons "a" #t) (cons "b" #t))
            (list (cons "a" #t) (cons "b" #f))))
(test (add-var-to-env "c" (list (cons "a" #t) (cons "b" #t)))
      (list (list (cons "a" #t) (cons "b" #t) (cons "c" #t))
            (list (cons "a" #t) (cons "b" #t) (cons "c" #f))))
(test (add-var-to-env "c" (list (cons "a" #t) (cons "b" #f)))
      (list (list (cons "a" #t) (cons "b" #f) (cons "c" #t))
            (list (cons "a" #t) (cons "b" #f) (cons "c" #f))))
(test (add-var-to-env "c" (list (cons "a" #f) (cons "b" #t)))
      (list (list (cons "a" #f) (cons "b" #t) (cons "c" #t))
            (list (cons "a" #f) (cons "b" #t) (cons "c" #f))))
(test (add-var-to-env "c" (list (cons "a" #f) (cons "b" #f)))
      (list (list (cons "a" #f) (cons "b" #f) (cons "c" #t))
            (list (cons "a" #f) (cons "b" #f) (cons "c" #f))))

;; Tests add-var-to-env-list
(test (add-var-to-env-list "a" (list (list)))
      (list (list (cons "a" #t))
            (list (cons "a" #f))))
(test (add-var-to-env-list "b" (list (list (cons "a" #t))))
      (list (list (cons "a" #t) (cons "b" #t))
            (list (cons "a" #t) (cons "b" #f))))
(test (add-var-to-env-list "b" (list (list (cons "a" #f))))
      (list (list (cons "a" #f) (cons "b" #t))
            (list (cons "a" #f) (cons "b" #f))))
(test (add-var-to-env-list "b" (list (list (cons "a" #t))
                                     (list (cons "a" #f))))
      (list (list (cons "a" #t) (cons "b" #t))
            (list (cons "a" #t) (cons "b" #f))
            (list (cons "a" #f) (cons "b" #t))
            (list (cons "a" #f) (cons "b" #f))))
(test (add-var-to-env-list "c" (list (list (cons "a" #t) (cons "b" #t))
                                     (list (cons "a" #t) (cons "b" #f))
                                     (list (cons "a" #f) (cons "b" #t))
                                     (list (cons "a" #f) (cons "b" #f))))
      (list (list (cons "a" #t) (cons "b" #t) (cons "c" #t))
            (list (cons "a" #t) (cons "b" #t) (cons "c" #f))
            (list (cons "a" #t) (cons "b" #f) (cons "c" #t))
            (list (cons "a" #t) (cons "b" #f) (cons "c" #f))
            (list (cons "a" #f) (cons "b" #t) (cons "c" #t))
            (list (cons "a" #f) (cons "b" #t) (cons "c" #f))
            (list (cons "a" #f) (cons "b" #f) (cons "c" #t))
            (list (cons "a" #f) (cons "b" #f) (cons "c" #f))))

;; Tests add-var-list-to-env-list
(test (add-var-list-to-env-list (list) (list (list))) (list (list)))
(test (add-var-list-to-env-list (list) (list(list (cons "a" #t))
                                            (list (cons "a" #f))))
      (list (list (cons "a" #t))
            (list (cons "a" #f))))
(test (add-var-list-to-env-list (list "a") (list (list)))
      (list (list (cons "a" #t))
            (list (cons "a" #f))))
(test (add-var-list-to-env-list (list "b") (list (list (cons "a" #t))
                                                 (list (cons "a" #f))))
      (list (list (cons "a" #t) (cons "b" #t))
            (list (cons "a" #t) (cons "b" #f))
            (list (cons "a" #f) (cons "b" #t))
            (list (cons "a" #f) (cons "b" #f))))

;; Tests all-enviroments
(test (all-environments (list)) (list (list)))
(test (all-environments (list "a"))
      (list (list (cons "a" #t)) (list (cons "a" #f))))
(test (all-environments (list "a" "b"))
      (list (list (cons "a" #t) (cons "b" #t))
            (list (cons "a" #t) (cons "b" #f))
            (list (cons "a" #f) (cons "b" #t))
            (list (cons "a" #f) (cons "b" #f))))
(test (all-environments (list "a" "b" "c"))
      (list (list (cons "a" #t) (cons "b" #t) (cons "c" #t))
            (list (cons "a" #t) (cons "b" #t) (cons "c" #f))
            (list (cons "a" #t) (cons "b" #f) (cons "c" #t))
            (list (cons "a" #t) (cons "b" #f) (cons "c" #f))
            (list (cons "a" #f) (cons "b" #t) (cons "c" #t))
            (list (cons "a" #f) (cons "b" #t) (cons "c" #f))
            (list (cons "a" #f) (cons "b" #f) (cons "c" #t))
            (list (cons "a" #f) (cons "b" #f) (cons "c" #f))))


#| Tests P1 e |#
;; Tests eval
(test (eval (varp "a") (list (cons "a" #t))) #t)
(test (eval (varp "a") (list (cons "a" #f))) #f)
(test/exn (eval (varp "a") (list)) "variable a is not defined in environment")
(test/exn (eval (varp "a") (list (cons "b" #t))) "variable a is not defined in environment")

(test (eval (notp (varp "a")) (list (cons "a" #t))) #f)
(test (eval (notp (varp "a")) (list (cons "a" #f))) #t)
(test/exn (eval (notp (varp "a")) (list)) "variable a is not defined in environment")
(test/exn (eval (notp (varp "a")) (list (cons "b" #t))) "variable a is not defined in environment")

(test (eval (andp (varp "a") (varp "a")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval (andp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval (andp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #f))) #f)
(test (eval (andp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #t))) #f)
(test (eval (andp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #f))) #f)
(test/exn (eval (andp (varp "a") (varp "b")) (list (cons "b" #t))) "variable a is not defined in environment")
(test/exn (eval (andp (varp "a") (varp "b")) (list (cons "a" #t))) "variable b is not defined in environment")
(test/exn (eval (andp (varp "a") (varp "b")) (list)) "variable a is not defined in environment")
(test/exn (eval (andp (varp "a") (varp "b")) (list (cons "c" #t) (cons "d" #t))) "variable a is not defined in environment")

(test (eval (orp (varp "a") (varp "a")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval (orp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval (orp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #f))) #t)
(test (eval (orp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #t))) #t)
(test (eval (orp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #f))) #f)
(test/exn (eval (orp (varp "a") (varp "b")) (list (cons "b" #t))) "variable a is not defined in environment")
(test/exn (eval (orp (varp "a") (varp "b")) (list (cons "a" #t))) "variable b is not defined in environment")
(test/exn (eval (orp (varp "a") (varp "b")) (list)) "variable a is not defined in environment")
(test/exn (eval (orp (varp "a") (varp "b")) (list (cons "c" #t) (cons "d" #t))) "variable a is not defined in environment")

(test (eval (orp (varp "a") (andp (varp "a") (notp (varp "a")))) (list (cons "a" #t))) #t)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #t) (cons "c" #t))) #t)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #t) (cons "c" #f))) #t)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #f) (cons "c" #t))) #t)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #f) (cons "c" #f))) #t)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #t) (cons "c" #t))) #f)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #t) (cons "c" #f))) #t)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #f) (cons "c" #t))) #f)
(test (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #f) (cons "c" #f))) #f)
(test/exn (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "b" #t) (cons "c" #t))) "variable a is not defined in environment")
(test/exn (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "c" #t))) "variable b is not defined in environment")
(test/exn (eval (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #t))) "variable c is not defined in environment")


#| Tests P1 f |#
;; Tests multi-env-eval
(test (multi-env-eval (varp "a") (list (list (cons "a" #t)))) #t)
(test (multi-env-eval (varp "a") (list (list (cons "a" #f)))) #f)
(test (multi-env-eval (varp "a") (list (list (cons "a" #t)) (list (cons "a" #f)))) #f)
(test (multi-env-eval (notp (varp "a")) (list (list (cons "a" #t)))) #f)
(test (multi-env-eval (notp (varp "a")) (list (list (cons "a" #f)))) #t)
(test (multi-env-eval (notp (varp "a")) (list (list (cons "a" #t)) (list (cons "a" #f)))) #f)
(test (multi-env-eval (orp (varp "a") (varp "b")) (list (list (cons "a" #t) (cons "b" #t)))) #t)
(test (multi-env-eval (orp (varp "a") (varp "b")) (list (list (cons "a" #t) (cons "b" #f)))) #t)
(test (multi-env-eval (orp (varp "a") (varp "b")) (list (list (cons "a" #f) (cons "b" #t)))) #t)
(test (multi-env-eval (orp (varp "a") (varp "b")) (list (list (cons "a" #f) (cons "b" #f)))) #f)
(test (multi-env-eval (orp (varp "a") (varp "b")) (list (list (cons "a" #t) (cons "b" #t))
                                                        (list (cons "a" #t) (cons "b" #f))
                                                        (list (cons "a" #f) (cons "b" #t)))) #t)
(test (multi-env-eval (orp (varp "a") (varp "b")) (list (list (cons "a" #t) (cons "b" #t))
                                                        (list (cons "a" #t) (cons "b" #f))
                                                        (list (cons "a" #f) (cons "b" #t))
                                                        (list (cons "a" #f) (cons "b" #f)))) #f)
(test (multi-env-eval (andp (varp "a") (varp "b")) (list (list (cons "a" #t) (cons "b" #t))
                                                         (list (cons "a" #t) (cons "b" #f))
                                                         (list (cons "a" #f) (cons "b" #t))
                                                         (list (cons "a" #f) (cons "b" #f)))) #f)
(test (multi-env-eval (andp (varp "a") (varp "b")) (list (list (cons "a" #t) (cons "b" #t)))) #t)

;; Tests tautology?
(test (tautology? (varp "a")) #f)
(test (tautology? (notp (varp "a"))) #f)
(test (tautology? (orp (varp "a") (varp "b"))) #f)
(test (tautology? (andp (varp "a") (varp "b"))) #f)
(test (tautology? (orp (varp "a") (notp (varp "a")))) #t)
(test (tautology? (orp (varp "a") (notp (varp "b")))) #f)
(test (tautology? (andp (varp "a") (notp (varp "a")))) #f)
(test (tautology? (notp (andp (varp "a") (notp (varp "a"))))) #t)




#| Tests P2 a |#
;; Tests simplify-negations
(test (simplify-negations (varp "a" )) (varp "a"))
(test (simplify-negations (notp (varp "a"))) (notp (varp "a")))
(test (simplify-negations (notp (notp (varp "a")))) (varp "a"))
(test (simplify-negations (notp (andp (varp "a") (varp "b")))) (orp (notp (varp "a")) (notp (varp "b"))))
(test (simplify-negations (notp (orp (varp "a") (varp "b")))) (andp (notp (varp "a")) (notp (varp "b"))))
(test (simplify-negations (notp (orp (notp (varp "a")) (varp "b")))) (andp (notp (notp (varp "a"))) (notp (varp "b"))))


#| Tests P2 b |#
;; Tests distribute-and
(test (distribute-and (varp "a")) (varp "a"))
(test (distribute-and (notp (varp "a"))) (notp (varp "a")))
(test (distribute-and (orp (varp "a") (varp "b"))) (orp (varp "a") (varp "b")))
(test (distribute-and (andp (varp "a") (varp "b"))) (andp (varp "a") (varp "b")))
(test (distribute-and (andp (orp (varp "a") (varp "b")) (varp "c")))
      (orp (andp (varp "a") (varp "c")) (andp (varp "b") (varp "c"))))
(test (distribute-and (andp (varp "c") (orp (varp "a") (varp "b"))))
      (orp (andp (varp "c") (varp "a")) (andp (varp "c") (varp "b"))))
(test (distribute-and (andp (orp (varp "a") (varp "b")) (orp (varp "c") (varp "d"))))
      (orp (andp (varp "a") (orp (varp "c") (varp "d"))) (andp (varp "b") (orp (varp "c") (varp "d"))))) 


#| Tests P2 c |#
;; Tests apply-until
(test ((apply-until (λ (x) (/ x (add1 x))) (λ (x new-x) (<= (- x new-x) 0.1))) 1) 0.25)
(test ((apply-until (λ (x) (* x 2)) (λ (x new-x) (equal? 48 (+ x new-x)))) 1) 32)
(test ((apply-until (λ (x) (+ x 1)) (λ (x new-x) (equal? 1 (- new-x x)))) 0) 1)


#| Tests P2 d |#
;; Tests simplify-all-negations
(test (simplify-all-negations (varp "a" )) (varp "a"))
(test (simplify-all-negations (notp (varp "a"))) (notp (varp "a")))
(test (simplify-all-negations (notp (notp (varp "a")))) (varp "a"))
(test (simplify-all-negations (notp (andp (varp "a") (varp "b")))) (orp (notp (varp "a")) (notp (varp "b"))))
(test (simplify-all-negations (notp (orp (varp "a") (varp "b")))) (andp (notp (varp "a")) (notp (varp "b"))))
(test (simplify-all-negations (notp (orp (notp (varp "a")) (varp "b")))) (andp (varp "a") (notp (varp "b"))))

;; Tests distribute-all-and
(test (distribute-all-and (varp "a")) (varp "a"))
(test (distribute-all-and (notp (varp "a"))) (notp (varp "a")))
(test (distribute-all-and (orp (varp "a") (varp "b"))) (orp (varp "a") (varp "b")))
(test (distribute-all-and (andp (varp "a") (varp "b"))) (andp (varp "a") (varp "b")))
(test (distribute-all-and (andp (orp (varp "a") (varp "b")) (varp "c")))
      (orp (andp (varp "a") (varp "c")) (andp (varp "b") (varp "c"))))
(test (distribute-all-and (andp (varp "c") (orp (varp "a") (varp "b"))))
      (orp (andp (varp "c") (varp "a")) (andp (varp "c") (varp "b"))))
(test (distribute-all-and (andp (orp (varp "a") (varp "b")) (orp (varp "c") (varp "d"))))
      (orp (orp (andp (varp "a") (varp "c")) (andp (varp "a") (varp "d"))) (orp (andp (varp "b") (varp "c")) (andp (varp "b") (varp "d")))))


;; Tests DNF
(test (DNF (varp "a")) (varp "a"))
(test (DNF (notp (varp "b"))) (notp (varp "b")))
(test (DNF (andp (varp "a") (varp "b"))) (andp (varp "a") (varp "b")))
(test (DNF (orp (varp "a") (varp "b"))) (orp (varp "a") (varp "b")))
(test (DNF (andp (orp (varp "a") (varp "b")) (orp (varp "c") (varp "d")))) (orp
                                                                            (orp (andp (varp "a") (varp "c"))
                                                                                 (andp (varp "a") (varp "d")))
                                                                            (orp (andp (varp "b") (varp "c"))
                                                                                 (andp (varp "b") (varp "d")))
                                                                            ))



#| Tests P3 a |#
;; fold-prop queda testeado con los tests para occurrences-2, vars-2, eval-2, simplify-negations-2 y distribute-and-2,
;; ya que las funciones mencionadas son implementadas con fold-prop.s

#| Tests P3 b |#

;; Tests occurrences-2
(test (occurrences-2 (varp "a") "b") 0)
(test (occurrences-2 (varp "a") "a") 1)
(test (occurrences-2 (notp (varp "a")) "b") 0)
(test (occurrences-2 (notp (varp "a")) "a") 1)
(test (occurrences-2 (andp (varp "a") (varp "b")) "c") 0)
(test (occurrences-2 (andp (varp "a") (varp "b")) "a") 1)
(test (occurrences-2 (andp (varp "a") (varp "a")) "a") 2)
(test (occurrences-2 (orp (varp "a") (varp "b")) "c") 0)
(test (occurrences-2 (orp (varp "a") (varp "b")) "a") 1)
(test (occurrences-2 (orp (varp "a") (varp "a")) "a") 2)
(test (occurrences-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) "d") 0)
(test (occurrences-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) "a") 1)
(test (occurrences-2 (orp (varp "a") (andp (varp "b") (notp (varp "a")))) "a") 2)
(test (occurrences-2 (orp (varp "a") (andp (varp "a") (notp (varp "a")))) "a") 3)


;; Tests vars-2
(test (vars-2 (varp "a")) (list "a"))
(test (vars-2 (notp (varp "a"))) (list "a"))
(test (vars-2 (andp (varp "a") (varp "b"))) (list "a" "b"))
(test (vars-2 (andp (varp "a") (varp "a"))) (list "a"))
(test (vars-2 (orp (varp "a") (varp "b"))) (list "a" "b"))
(test (vars-2 (orp (varp "a") (varp "a"))) (list "a"))
(test (vars-2 (orp (varp "a") (andp (varp "b") (notp (varp "c"))))) (list "a" "b" "c"))
(test (vars-2 (orp (varp "a") (andp (varp "b") (notp (varp "b"))))) (list "a" "b"))
(test (vars-2 (orp (varp "c") (andp (varp "c") (notp (varp "c"))))) (list "c"))


;; Tests eval-2
(test (eval-2 (varp "a") (list (cons "a" #t))) #t)
(test (eval-2 (varp "a") (list (cons "a" #f))) #f)
(test/exn (eval-2 (varp "a") (list)) "variable a is not defined in environment")
(test/exn (eval-2 (varp "a") (list (cons "b" #t))) "variable a is not defined in environment")

(test (eval-2 (notp (varp "a")) (list (cons "a" #t))) #f)
(test (eval-2 (notp (varp "a")) (list (cons "a" #f))) #t)
(test/exn (eval-2 (notp (varp "a")) (list)) "variable a is not defined in environment")
(test/exn (eval-2 (notp (varp "a")) (list (cons "b" #t))) "variable a is not defined in environment")

(test (eval-2 (andp (varp "a") (varp "a")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval-2 (andp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval-2 (andp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #f))) #f)
(test (eval-2 (andp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #t))) #f)
(test (eval-2 (andp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #f))) #f)
(test/exn (eval-2 (andp (varp "a") (varp "b")) (list (cons "b" #t))) "variable a is not defined in environment")
(test/exn (eval-2 (andp (varp "a") (varp "b")) (list (cons "a" #t))) "variable b is not defined in environment")
(test/exn (eval-2 (andp (varp "a") (varp "b")) (list)) "variable a is not defined in environment")
(test/exn (eval-2 (andp (varp "a") (varp "b")) (list (cons "c" #t) (cons "d" #t))) "variable a is not defined in environment")

(test (eval-2 (orp (varp "a") (varp "a")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval-2 (orp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #t))) #t)
(test (eval-2 (orp (varp "a") (varp "b")) (list (cons "a" #t) (cons "b" #f))) #t)
(test (eval-2 (orp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #t))) #t)
(test (eval-2 (orp (varp "a") (varp "b")) (list (cons "a" #f) (cons "b" #f))) #f)
(test/exn (eval-2 (orp (varp "a") (varp "b")) (list (cons "b" #t))) "variable a is not defined in environment")
(test/exn (eval-2 (orp (varp "a") (varp "b")) (list (cons "a" #t))) "variable b is not defined in environment")
(test/exn (eval-2 (orp (varp "a") (varp "b")) (list)) "variable a is not defined in environment")
(test/exn (eval-2 (orp (varp "a") (varp "b")) (list (cons "c" #t) (cons "d" #t))) "variable a is not defined in environment")

(test (eval-2 (orp (varp "a") (andp (varp "a") (notp (varp "a")))) (list (cons "a" #t))) #t)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #t) (cons "c" #t))) #t)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #t) (cons "c" #f))) #t)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #f) (cons "c" #t))) #t)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #f) (cons "c" #f))) #t)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #t) (cons "c" #t))) #f)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #t) (cons "c" #f))) #t)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #f) (cons "c" #t))) #f)
(test (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #f) (cons "b" #f) (cons "c" #f))) #f)
(test/exn (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "b" #t) (cons "c" #t))) "variable a is not defined in environment")
(test/exn (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "c" #t))) "variable b is not defined in environment")
(test/exn (eval-2 (orp (varp "a") (andp (varp "b") (notp (varp "c")))) (list (cons "a" #t) (cons "b" #t))) "variable c is not defined in environment")


;; Tests simplify-negations-2
(test (simplify-negations-2 (varp "a" )) (varp "a"))
(test (simplify-negations-2 (notp (varp "a"))) (notp (varp "a")))
(test (simplify-negations-2 (notp (notp (varp "a")))) (varp "a"))
(test (simplify-negations-2 (notp (andp (varp "a") (varp "b")))) (orp (notp (varp "a")) (notp (varp "b"))))
(test (simplify-negations-2 (notp (orp (varp "a") (varp "b")))) (andp (notp (varp "a")) (notp (varp "b"))))
(test (simplify-negations-2 (notp (orp (notp (varp "a")) (varp "b")))) (andp (notp (notp (varp "a"))) (notp (varp "b"))))


;; Tests distribute-and-2
(test (distribute-and-2 (varp "a")) (varp "a"))
(test (distribute-and-2 (notp (varp "a"))) (notp (varp "a")))
(test (distribute-and-2 (orp (varp "a") (varp "b"))) (orp (varp "a") (varp "b")))
(test (distribute-and-2 (andp (varp "a") (varp "b"))) (andp (varp "a") (varp "b")))
(test (distribute-and-2 (andp (orp (varp "a") (varp "b")) (varp "c")))
      (orp (andp (varp "a") (varp "c")) (andp (varp "b") (varp "c"))))
(test (distribute-and-2 (andp (varp "c") (orp (varp "a") (varp "b"))))
      (orp (andp (varp "c") (varp "a")) (andp (varp "c") (varp "b"))))
(test (distribute-and-2 (andp (orp (varp "a") (varp "b")) (orp (varp "c") (varp "d"))))
      (orp (andp (varp "a") (orp (varp "c") (varp "d"))) (andp (varp "b") (orp (varp "c") (varp "d"))))) 
