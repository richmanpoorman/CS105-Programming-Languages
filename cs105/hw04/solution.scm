;;;; HIGHER-ORDER FUNCTIONS AND THE 9-STEP PROCESS ;;;; 

;; (flip f) Given a binary function (a function with 2 parameters) f, the 
;; function returns the function with the parameters swapped, so 
;; (f x y) will be equal to ((flip f) y x); in other words, flip returns a
;; function which expects the arguments in the opposite order

;; laws
;;      (flip f)     == result
;;      (result y x) == (f x y)
(define flip (f) (lambda (x y) (f y x)))

;; (takewhile p? xs) Given a predicate p? and a list xs, the function returns
;; the longest prefix of the list which satisfies the predicate 

;; laws 
;;      (takewhile p? '()) == '()
;;      (takewhile p? (cons y ys)) == 
;;          (cons y (takewhile p? ys)) when (p? y) = #t
;;      (takewhile p? (cons y ys)) == '() when (p? y) = #f 
(define takewhile (p? xs)
    (if (null? xs) 
        '()
        (if (p? (car xs))
            (cons (car xs) (takewhile p? (cdr xs)))
            '() )))

;; (dropwhile p? xs) Given a predicate p? and a list xs, the function returns
;; the list with the longest prefix satisfying the predicate removed

;; laws
;;      (dropwhile p? '()) == '()
;;      (dropwhile p? (cons y ys)) == (dropewhile p? ys) when (p? y) = #t
;;      (dropwhile p? (cons y ys)) == (cons y ys) when (p? y) = #f
(define dropwhile (p? xs)
    (if (null? xs) 
        '()
        (if (p? (car xs))
            (dropwhile p? (cdr xs))
            xs )))

;; (ordered-by precedes?) Given a comparison function (a binary function
;; which returns a boolean) precedes, the function returns a predicate 
;; on lists which returns if true if the list is totally ordered by the 
;; comparison function, or false otherwise

;; laws
;;      (ordered-by precedes?) == result
;;      (result '()) == #t
;;      (result (cons y '())) == #t
;;      (result (cons y (cons z zs))) == 
;;          (&& (precedes? y z) (result (cons z zs)))
(define ordered-by (precedes?) 
    (letrec 
        ([is-ordered? 
            (lambda (xs) 
                (if (|| (null? xs) (null? (cdr xs)))
                    #t 
                    (&& 
                        (precedes? (car xs) (cadr xs)) 
                        (is-ordered? (cdr xs) ))))])
            is-ordered?))

;;;; USING CLASSIC HIGHER-ORDER FUNCTIONS ;;;; 

;; (max* xs) Given a non-empty list of numbers xs, the function returns 
;; the maximum value of the list 
(define max* (xs) (foldl max (car xs) (cdr xs)))

;; (sum xs) Given a non-empty list of numbers xs, the function returns the 
;; sum of all of the values of the list 
(define sum (xs) (foldl + 0 xs))

;; (product xs) Given a non-empty list of numbers xs, the function returns the 
;; product of all of the value of the list
(define product (xs) (foldl * 1 xs))

;; (append xs ys) Given two lists xs and ys, the function returns a list that 
;; is xs appended to ys 
(define append (xs ys) (foldr cons ys xs)) 

;; (reverse xs) Given a list xs, the function returns a reversed version of xs
(define reverse (xs) (foldl cons '() xs))

;; (map f xs) Given a single-argument function f and a list of inputs for the 
;; the function xs, the function returns the list of the results of running 
;; f on each element of xs 
(define map (f xs) 
    (foldr 
        (lambda (x acc) (cons (f x) acc)) 
        '() 
        xs ))

;; (filter p? xs) Given a predicate p? and a list of values that work on the 
;; predicate xs, the function returns a list of the values from xs which 
;; satisfy the predicate
(define filter (p? xs) 
    (foldr 
        (lambda (x acc) 
            (if (p? x)
                (cons x acc)
                acc))
        '()
        xs ))

;; (exists? p? xs) Given a predicate p? and a list of values that work on the 
;; predicate xs, the function returns true if there exists an element in the 
;; list which satisfies the predicate, and false otherwise 
(define exists? (p? xs) 
    (foldr 
        (lambda (x acc) (|| (p? x) acc))
        #f 
        xs ))

;; (all? p? xs) Given a predicate p? and a list of values that work on the 
;; predicate xs, the function returns true if all elements of the list satisfy
;; the predicate, and false otherwise
(define all? (p? xs) 
    (foldr
        (lambda (x acc) (&& (p? x) acc))
        #t 
        xs ))


;;;; FUNCITONS AS SETS ;;; 
(val empty-set (lambda (x) #f))
(define member? (x s) (s x))

;; (evens x) A set which contains all the even integers, and given a value x,
;; returns true if it is in the set and false otherwise
(val evens 
    (lambda (x) (&& (number? x) (= 0 (mod x 2)))))

;; (two-digits x) A set which contains all the 2-digit positive integers, and 
;; given a value x, returns true if it is in the set and false otherwise
(val two-digits 
    (lambda (x) (&& (number? x) (&& (> x 9) (< x 100)))))

;; (add-element x s) Given an element to add x, and a set s, the function 
;; will return a set with the element x added to s if x is not is s, or
;; a copy of s if x is in s

;; laws 
;;      (member? x (add-element x s)) == #t
;;      (member? x (add-element y s)) == 
;;          (member? x s), where (not (equal? y x))
(define add-element (x s) 
    (if (member? x s) 
        s 
        (lambda (y) (|| (equals? y x) (member? y s))) ))

;; (union s1 s2) Given two sets s1 and s2, the function returns a set which is 
;; union of the two sets s1 and s2 

;; laws 
;;      (member? x (union s1 s2)) == (|| (member? x s1) (member? x s2))
(define union (s1 s2) 
    (lambda (x) (|| (member? x s1) (member? x s2)))) 

;; (inter s1 s2) Given two sets s1 and s2, the function returns a set which is 
;; the intersection of the two sets s1 and s2

;; laws 
;;      (member? x (inter s1 s2)) == (&& (member? x s1) (member? x s2))
(define inter (s1 s2)
    (lambda (x) (&& (member? x s1) (member? x s2))))

;; (diff s1 s2) Given two sets s1 and s2, the function returns a set which is 
;; the difference of s1 - s2; in other words, it is the set of elements of s1
;; which are not in s2 

;; laws 
;;      (member? x (diff s1 s2)) == (&& (member? x s1) (not (member? x s2)))
(define diff (s1 s2) 
    (lambda (x) (&& (member? x s1) (not (member? x s2)))))