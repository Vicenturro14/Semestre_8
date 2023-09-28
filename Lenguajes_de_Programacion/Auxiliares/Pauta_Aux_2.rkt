#lang play
(print-only-errors)

#|
a) <FSResource> ::= (file <Symbol>)
                  | (folder <Symbol> [<FSResource> ...])
|#
;; Inductive type for representing resources of
;; a file system
(deftype FSResource
  (file file-name)
  (folder folder-name resources))

;; parse :: SRC -> FSResource
;; Parse the user input into a FSResource
(define (parse src)
  (match src
    [(list 'file file-name) (file file-name)]
    [(list 'folder folder-name src-resources)
     (folder folder-name (map parse src-resources))]))
(test (parse `(file aux1.rkt))
      (file 'aux1.rkt))
(test (parse `(folder root []))
      (folder 'root '()))
(test (parse `(folder root [(file aux1.rkt)]))
      (folder 'root (list (file 'aux1.rkt))))

(define (parse-2 src)
  (define (parse-2-resources resources)
    (match resources
      ['() '()]
      [(cons res resources-tl) (cons
                                (parse-2 res)
                                (parse-2-resources resources-tl))]))
  (match src
    [(list 'file file-name) (file file-name)]
    [(list 'folder folder-name src-resources)
     (folder folder-name (parse-2-resources src-resources))]))
(test (parse-2 `(file aux1.rkt))
      (file 'aux1.rkt))
(test (parse-2 `(folder root []))
      (folder 'root '()))
(test (parse-2 `(folder root [(file aux1.rkt)]))
      (folder 'root (list (file 'aux1.rkt))))

;; count-files :: FSResource -> Number
;; Count the number of files in the given resource
(define (count-files fsr)
  (match fsr
    [(file _) 1]
    [(folder folder_name resources_list)
     (match resources_list
       [(list resource resources ...)
        (+ (count-files resource)
           (count-files (folder folder_name resources)))]
       ['() 0])]))
(test (count-files (parse '(folder root [
                                         (folder tmp [])
                                         (folder usr [(file aux1.rkt)])
                                         ])))
      1)
(test (count-files (parse '(folder root [])))
      0)

;; find :: <Symbol> FSResource -> List[Pair[String, FSResource]]
;; Search in the resource for all the files with the given name

(define (find find-name fsr)
  (define (find-aux find-name fsr path)
    (match fsr
      [(file file-name)
       (if (equal? file-name find-name)
           (list (cons path fsr))
           '())]
      [(folder folder-name resources)
       (apply append (map
                      (lambda (resource)
                        (find-aux find-name
                                  resource
                                  (string-append path
                                                 (symbol->string folder-name)
                                                 "/")))
                      resources))]))
  (find-aux find-name fsr "/"))
(test (find 'aux1.rkt (parse `(file aux1.rkt)))
      (list (cons "/" (file 'aux1.rkt))))
(test (find 'foo.c (parse `(file aux1.rkt)))
      '())
(test (find 'aux1.rkt (parse `(folder root[
                                           (folder tmp [])
                                           (folder usr [(file aux1.rkt)])
                                           ])))
      (list (cons "/root/usr/" (file 'aux1.rkt))))
(test (find 'aux1.rkt (parse `(folder root[
                                           (folder tmp [])
                                           (folder usr [(file aux1.rkt)])
                                           (file aux1.rkt)
                                           ])))
      (list (cons "/root/usr/" (file 'aux1.rkt))
            (cons "/root/" (file 'aux1.rkt))))
(test (find 'foo.c (parse `(folder root [])))
      '())


;; fold-fsr (<Symbol> -> A) (<Symbol> List[A] -> A) -> (FSResource -> A)
;; Captures the recursion scheme for FSResource inductive type.
(define (fold-fsr f g)
  (lambda (fsr)
    (match fsr
      [(file file-name) (f file-name)]
      [(folder folder-name resources)
       (g folder-name
          (map (lambda (resource) ((fold-fsr f g) resource)) resources))])))

;; count-files* :: FSResource -> Number
(define (count-files* fsr)
  ((fold-fsr
    (lambda (file-name) 1)
    (lambda (folder-name counts) (apply + counts)))
   fsr))
(test (count-files* (parse '(folder root [
                                          (folder tmp [])
                                          (folder usr [(file aux1.rkt)])
                                          ])))
      1)
(test (count-files* (parse '(folder root [])))
      0)

;; find* :: <Symbol> FSResource -> List[Pair[String, FSResource]]
(define (find* find-name fsr)
  ((fold-fsr
    (lambda (file-name) (if (equal? file-name find-name)
                            (list (cons "/"
                                        (file file-name)))
                            '()))                               
    (lambda (folder-name founded-resources)
      (let [(flaten-resources (foldl append '() founded-resources))]
        (map (lambda (founded-res)
               (cons (string-append "/"
                                    (symbol->string folder-name)
                                    (car founded-res))
                     (cdr founded-res)))
             flaten-resources))))
   fsr))
(test (find* 'aux1.rkt (parse `(file aux1.rkt)))
      (list (cons "/" (file 'aux1.rkt))))
(test (find* 'foo.c (parse `(file aux1.rkt)))
      '())
(test (find* 'aux1.rkt (parse `(folder root[
                                           (folder tmp [])
                                           (folder usr [(file aux1.rkt)])
                                           ])))
      (list (cons "/root/usr/" (file 'aux1.rkt))))
(test (find* 'aux1.rkt (parse `(folder root[
                                           (folder tmp [])
                                           (folder usr [(file aux1.rkt)])
                                           (file aux1.rkt)
                                           ])))
      (list (cons "/root/" (file 'aux1.rkt))
            (cons "/root/usr/" (file 'aux1.rkt))))
(test (find* 'foo.c (parse `(folder root [])))
      '())

;; display-fs :: FSResource -> String
;; Display the file system in the std-out.
(define (display-fs fsr)
  (define (display-aux fsr level)
    (match fsr
      [(file file-name)
       (printf "~s~n" (string-append (make-string level #\space) (symbol->string file-name)))]
      [(folder folder-name resources)
       (printf "~s~n" (string-append (make-string level #\space) (symbol->string folder-name)))
       (map (lambda (resource) (display-aux resource (add1 level))) resources)]))
  (display-aux fsr 0))
#;(display-fs (parse `(folder root[
                                 (folder tmp [])
                                 (folder usr [(file aux1.rkt)])
                                 ])))