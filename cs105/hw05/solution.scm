
;;
;; Question 2
;;

;; (list-of? A? v) Given a predicate which can take any value A? and 
;; any arbitrary uScheme value v, the function returns #t if v is a list 
;; and all of the values in v satisfy the predicate A?, and returns 
;; #f otherwise 

;; laws:
;;      (list-of? A? v)           == #f, when (not (pair? v))
;;      (list-of? A? '())         == #t
;;      (list-of? A? (cons y ys)) == #f, when (not (A? y))
;;      (list-of? A? (cons y ys)) == (list-of? A? ys)
(define list-of? (A? v) 
    (if (pair? v)
        (if (null? v) 
            #t 
            (if (A? (car v))
                (list-of? A? (cdr v))
                #f))
        #f ))

;; 
;; Question 3 
;; 

(record not [arg])
(record or  [args])
(record and [args])

;; (forula? f) Given an arbitrary uScheme value f, the function returns 
;; #t if f represents a boolean formula, and #f otherwise 

;; laws: 
;;      (formula? f)               == #t, when (symbol? f) 
;;      (formula? (make-not arg))  == (formula? arg) 
;;      (formula? (make-or args))  == (list-of? formula? (or-args args))
;;      (formula? (make-and args)) == (list-of? formula? (and-args args))
;;      (formula? f)               == #f, otherwise
(define formula? (f) 
    (if (symbol? f)
        #t 
        (if (not? f) 
            (formula? (not-arg f))
            (if (or? f)
                (list-of? formula? (or-args f))
                (if (and? f) 
                    (list-of? formula (and-args? f))
                    #f )))))

;; 
;; Question 4
;; 

;; (eval-formula f env) Given a boolean formula f and a variable enviornment v,
;; where all variables in f are bound in v, the function returns #t if f 
;; evaluates to true with the assignments of v, and #f otherwise; 
;; Note that a variable enviornment is a association list where the key 
;; is a symbol representing the boolean variable, and the each of the 
;; values are boolean literals

;; laws:
;;      (eval-formula f env) == (find f env), when (symbol? f)
;;      (eval-formula (make-not arg) env) == (not (eval-formula arg env))
;;      (eval-formula (make-or args) env) ==
;;          (not (list-of? 
;;              (lambda (x) (not (eval-formula x env))) 
;;              args ))
;;      (eval-formula (make-and args) env) == 
;;          (list-of? 
;;              (lambda (x) (eval-formula x env))
;;              args )
;;      (eval-formula f env) == #f, otherwise
(define eval-formula (f env) 
    (if (symbol? f) 
        (find f env) 
        (if (not? f) 
            (not (eval-formula (not-arg f) env))
            (if (or? f) 
                (not (list-of? 
                    (lambda (x) (not (eval-formula x env)))
                    (or-args f)))
                (if (and? f) 
                    (list-of? 
                        (lambda (x) (eval-formula x env))
                        (and-args f)
                        )
                    #f )))))

;; 
;; Question 5
;; 