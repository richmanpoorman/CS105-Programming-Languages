
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
        (if (A? (car v))
            (list-of? A? (cdr v))
            #f)
        (null? v)  ))

        (check-assert (list-of? boolean? '(#t #f #f #t)))
        (check-assert (list-of? number? '()))
        (check-assert (list-of? symbol? '(a)))
        (check-assert (list-of? symbol? '(x y z)))
        (check-assert (list-of? 
                        (lambda (x) (list-of? symbol? x))
                        '((x y) () (x y z))))
        (check-assert (not (list-of? 
                                (lambda (x) (list-of? symbol? x))
                                '((x y) () (x y z) (12)))))
        (check-assert (not (list-of? symbol? '(a b () c d))))
        (check-assert (not (list-of? boolean? (cons #t #f))))
        (check-assert (not (list-of? atom? 'COMP)))

;; 
;; Question 3 
;; 

(record not [arg])
(record or  [args])
(record and [args])

;; (formula? f) Given an arbitrary uScheme value f, the function returns 
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
                    (list-of? formula? (and-args f))
                    #f )))))

        (check-assert (formula? 'x))
        (check-assert (formula? (make-not 'x)))
        (check-assert (formula? (make-or '(x y) )))
        (check-assert (formula? (make-and '(x y) )))
        (check-assert (formula? 
                        (make-not (make-and (list2 (make-or '(x)) 'x)))))
        (check-assert (not (formula? formula?)))
        (check-assert (not (formula? '())))
        (check-assert (not (formula? (make-not '()))))
        (check-assert (not (formula? (make-or '(x ()) ))))
        (check-assert (not (formula? (make-and '(x () ())) )))
        (check-assert (formula? (make-or '())))
        (check-assert (formula? (make-and '())))

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
;;                  (lambda (x) (not (eval-formula x env))) 
;;                  args ))
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
                        (and-args f))
                    #f )))))

        (check-assert (eval-formula 
                        (make-and '(x y z))
                        '((x #t) (y #t) (z #t))))
        (check-assert (not (eval-formula 
                            (make-and '(x y z)) 
                            '((x #t) (y #t) (z #f)))))
        (check-assert (eval-formula 
                        (make-or '(x y z))
                        '((x #f) (x #f) (z #t))))
        (check-assert (not (eval-formula 
                            (make-or '(x y z))
                            '((x #f) (y #f) (z #f)) )))
        (check-assert (eval-formula 
                        (make-not 'x)
                        '((x #f))))
        (check-assert (not (eval-formula 
                            (make-not 'x)
                            '((x #t)))))
        (check-assert (eval-formula 'x '((x #t))))
        (check-assert (not (eval-formula 'x '((x #f)))))
        (check-assert (eval-formula (make-and '(x)) '((x #t))))
        (check-assert (eval-formula (make-or '(x)) '((x #t))))
        (check-assert (eval-formula 
                        (make-and 
                            (list3 
                                (make-or '(x)) 
                                (make-or (list2 (make-not 'x) 'x))
                                (make-and (list2 
                                            (make-not (make-not 'x))
                                            (make-or '(x))))))
                        '((x #t))))
        (check-assert (not (eval-formula 
                            (make-and 
                                (list3 
                                    (make-or '(x)) 
                                    (make-or (list2 (make-not 'x) 'x))
                                    (make-and (list2 
                                                (make-not (make-not 'x))
                                                (make-or '(x)))))) 
                            '((x #f)))))
        (check-assert (not (eval-formula 
                                (make-or '(x)) 
                                '((x #f)))))

;; 
;; Question 5
;; 

;; (solve-sat f fail succ) Given a boolean formula f, a fail closure which
;; takes no parameters fail, and a success closure which takes an association
;; list representing the variable enviornment env with the keys being the 
;; boolean variable symbol and the values being what the boolean variable 
;; is set to and a resume continuation which doesn't take any variables, and 
;; the function searches for an enviornment which satisfies the 
;; boolean formula f, and if it finds an enviornment that succeeds, the 
;; function passes the enviornment which satisifies the formula to the 
;; success continutation, or calls the fail continuation if it can't 
;; find an enviornment which satisfies the formula 

;; laws: 
;;      (solve-sat f fail succ) == (solve-formula f #t '() fail succ)

(define solve-sat (f fail succ) 
    (letrec
        (
        ;; (solve-forumla f bool cur fail succeed) Given a boolean formula f,
        ;; a target boolean to evaluate to bool, an association list 
        ;; representing a variable enviornment cur, a fail continuation which
        ;; takes no parameters fail, and a success continuation which takes 
        ;; a successful enviornment env and a resume continutation which 
        ;; takes to no parameters, the function uses the succeed continuation 
        ;; if the function successfully finds an enviornment which satisfies
        ;; the formula, and uses the fail continuation if no enviornments
        ;; satisfy the boolean formula 

        ;; laws: 
        ;;     (solve-formula x             bool cur fail succeed) == 
        ;;          (solve-symbol x bool cur fail succeed),
        ;;              where x is a symbol
        ;;     (solve-formula (make-not f)  bool cur fail succeed) == 
        ;;          (solve-formula f (not bool) cur fail succeed)
        ;;     (solve-formula (make-or  fs) #t   cur fail succeed) == 
        ;;          (solve-any fs #t cur fail succeed)
        ;;     (solve-formula (make-or  fs) #f   cur fail succeed) == 
        ;;          (solve-all fs #f cur fail succeed)
        ;;     (solve-formula (make-and fs) #t   cur fail succeed) == 
        ;;          (solve-all fs #t cur fail succeed)
        ;;     (solve-formula (make-and fs) #f   cur fail succeed) == 
        ;;          (solve-any fs #f cur fail succeed)
         [solve-formula 
            (lambda (f bool cur fail succeed) 
                (if (symbol? f) 
                    (solve-symbol f bool cur fail succeed)
                    (if (not? f) 
                        (solve-formula (not-arg f) (not bool) cur fail succeed)
                        (if (or? f) 
                            (if bool 
                                (solve-any (or-args f) #t cur fail succeed)
                                (solve-all (or-args f) #f cur fail succeed))
                            (if (and? f) 
                                (if bool 
                                    (solve-all (and-args f) #t 
                                        cur fail succeed)
                                    (solve-any (and-args f) #f 
                                        cur fail succeed)) 
                                ;; If not given proper boolean formula
                                (fail) )))))] 
        
        ;; (solve-all fs bool cur fail succeed) Given a list of boolean 
        ;; formulas fs, a target boolean for all of the formulas to evaluate to
        ;; bool, the current boolean variable enviornment cur, a failure
        ;; continuation which takes no parameters fail, and a success 
        ;; continuation which takes a variable enviornment env and a 
        ;; resume continuation resume, the function calls the success 
        ;; continuation if the functions finds an enviornment which makes ALL
        ;; functions in fs evaluate to bool, giving it the enviornment and fail
        ;; continuation, or calls the fail continuation if it the function can
        ;; not find an enviornment which makes all fs evaluate to bool

        ;; laws: 
        ;;      (solve-all '()         bool cur fail succeed) == 
        ;;          (succeed cur fail)
        ;;      (solve-all (cons f fs) bool cur fail succeed) == 
        ;;          (solve-formula f bool cur fail 
        ;;              (lambda (env resume) 
        ;;                  (solve-all fs bool env resume succeed) ))
         [solve-all 
            (lambda (fs bool cur fail succeed) 
                (if (null? fs) 
                    (succeed cur fail) 
                    (solve-formula (car fs) bool cur fail 
                        (lambda (env resume) 
                            (solve-all (cdr fs) bool env resume succeed) ))))] 

        ;; (solve-all fs bool cur fail succeed) Given a list of boolean 
        ;; formulas fs, a target boolean for all of the formulas to evaluate to
        ;; bool, the current boolean variable enviornment cur, a failure
        ;; continuation which takes no parameters fail, and a success 
        ;; continuation which takes a variable enviornment env and a 
        ;; resume continuation resume, the function calls the success 
        ;; continuation if the functions finds an enviornment which makes ANY
        ;; functions in fs evaluate to bool, giving it the enviornment and fail
        ;; continuation, or calls the fail continuation if it the function can
        ;; not find an enviornment which makes all fs evaluate to bool

        ;; laws: 
        ;;      (solve-any '()         bool cur fail succeed) == 
        ;;          (fail)
        ;;      (solve-any (cons f fs) bool cur fail succeed) == 
        ;;          (solve-formula f bool cur 
        ;;              (lambda () (solve-any fs bool cur fail succeed)) 
        ;;              succeed)
         [solve-any 
            (lambda (fs bool cur fail succeed) 
                (if (null? fs) 
                    (fail) 
                    (solve-formula (car fs) bool cur 
                        (lambda () (solve-any (cdr fs) bool cur fail succeed))
                        succeed) ))]

        ;; (solve-symbol x bool cur fail succeed) Given a symbol which 
        ;; represents a boolean variable x, a boolean to make the evaluate to
        ;; bool, the current boolean variable enviornment cur, a failure 
        ;; continuation which takes no inputs fail, and a success continuation
        ;; which takes a variable enviornment env and a resume continuation 
        ;; resume, the function will assign x to bool if x is not assigned 
        ;; in cur, and will call the succeed continuation with the  
        ;; enviornment (after assigning) if the variable is assigned 
        ;; or the variable is bool in cur already, or calls the fail 
        ;; function if x is assigned to (not bool) in cur

        ;; laws:
        ;;      (solve-symbol x bool cur fail succeed) == 
        ;;          (succeed (bind x bool curr) fail),
        ;;              where x is not bound in cur
        ;;      (solve-symbol x bool cur fail succeed) == 
        ;;          (succeed cur fail), where x is bool in cur
        ;;      (solve-symbol x bool cur fail succeed) == 
        ;;          (fail), where x is (not bool) in cur
         [solve-symbol 
            (lambda (x bool cur fail succeed) 
                (let ([value (find x cur)])
                    (if (null? value) 
                        (succeed (bind x bool cur) fail) 
                        (if (equal? bool value)
                            (succeed cur fail) 
                            (fail) ))) )])
            
            ;; SOLVE THE FORMULA 
            (solve-formula f #t '() fail succ))) 

;; MY TESTS ;; 
        (check-expect 
            (solve-sat 
                (make-and '())
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect 
            (solve-sat 
                (make-or '())
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'fail )
        (check-expect 
            (solve-sat 
                'x
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect 
            (solve-sat 
                (make-or '(x))
                (lambda () 'fail)
                (lambda (env resume) 'success)) 
            'success)
        (check-expect 
            (solve-sat 
                (make-or (list2 (make-not 'x) 'x)) 
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect
            (solve-sat 
                (make-not (make-not 'x)) 
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect 
            (solve-sat 
                (make-and (list2 (make-not 'x) 'y)) 
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect 
            (solve-sat 
                (make-and (list1 (make-not 'x)))
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect 
            (solve-sat 
                (make-and (list2 
                            (make-or (list2 (make-not 'x) 'x)) 
                            (make-not 'x)))
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'success )
        (check-expect 
            (solve-sat 
                (make-or (list2 
                            (make-and (list2 'x (make-not 'x) )) 
                            (make-and (list2 'y (make-not 'y) )) ))
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'fail )
        (check-expect 
            (solve-sat 
                (make-and (list3 'x 'y 
                            (make-or (list2 (make-not 'x) (make-not 'y)))))
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'fail)
        (check-expect 
            (solve-sat 
                (make-and (list2 'x (make-not 'x) )) 
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'fail )
        (check-expect 
            (solve-sat 
                (make-and (list2 (make-not 'x) 'x)) 
                (lambda () 'fail)
                (lambda (env resume) 'success))
            'fail )

;;; TESTS ;;; 
        (check-assert (function? solve-sat))    ; correct name
        (check-error (solve-sat))                ; not 0 arguments
        (check-error (solve-sat 'x))             ; not 1 argument
        (check-error (solve-sat 'x (lambda () 'fail)))   ; not 2 args
        
        (check-error
            (solve-sat 'x (lambda () 'fail) (lambda (c r) 'succeed) 'z)) 
                ; not 4 args
        (check-error (solve-sat 'x (lambda () 'fail) (lambda () 'succeed)))
            ; success continuation expects 2 arguments, not 0
        (check-error (solve-sat 'x (lambda () 'fail) (lambda (_) 'succeed)))
            ; success continuation expects 2 arguments, not 1
        (check-error (solve-sat
                            (make-and (list2 'x (make-not 'x)))
                            (lambda (_) 'fail)
                            (lambda (_) 'succeed)))
            ; failure continuation expects 0 arguments, not 1


        (check-expect   ; x can be solved
            (solve-sat 'x
                        (lambda () 'fail)
                        (lambda (cur resume) 'succeed))
            'succeed)

        (check-expect   ; x is solved by '((x #t))
            (solve-sat 'x
                        (lambda () 'fail)
                        (lambda (cur resume) (find 'x cur)))
            #t)

        (check-expect   ; (make-not 'x) can be solved
            (solve-sat (make-not 'x)
                        (lambda () 'fail)
                        (lambda (cur resume) 'succeed))
            'succeed)

        (check-expect   ; (make-not 'x) is solved by '((x #f))
            (solve-sat (make-not 'x)
                        (lambda () 'fail)
                        (lambda (cur resume) (find 'x cur)))
            #f)

        (check-expect   ; (make-and (list2 'x (make-not 'x))) cannot be solved
            (solve-sat (make-and (list2 'x (make-not 'x)))
                        (lambda () 'fail)
                        (lambda (cur resume) 'succeed))
            'fail)

