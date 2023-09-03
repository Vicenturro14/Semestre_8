#lang play
(require "T1.rkt")
(print-only-errors #t)

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