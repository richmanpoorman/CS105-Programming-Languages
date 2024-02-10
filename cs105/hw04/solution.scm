;; Name       : Matthew Wong
;; Assignment : Homework 4: Higher-Order Functions
;; Due Date   : 12 Febuary 2024

;;;; HIGHER-ORDER FUNCTIONS AND THE 9-STEP PROCESS ;;;; 

;; 
;; Problem 2 
;;

;; (flip f) Given a binary function (a function with 2 parameters) f, the 
;; function returns the function with the parameters swapped, so 
;; (f x y) will be equal to ((flip f) y x); in other words, flip returns a
;; function which expects the arguments in the opposite order

;; laws
;;      (flip f)     == result
;;      (result y x) == (f x y)
(define flip (f) (lambda (x y) (f y x)))

        ;; Tests
        (check-assert (function? (flip <))) 
        (check-expect ((flip <) 1 2) (> 1 2))
        (check-expect ((flip <) 2 1) (> 2 1))
        (check-expect ((flip <) 1 1) (> 1 1))


;; 
;; Problem 3
;;

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

        ;; Tests
        (check-expect (takewhile null? '()) '())
        (check-expect (takewhile null? '(())) '(()))
        (check-expect (takewhile null? '(() 1 2 () 1 2 3 ())) '(()))
        (check-expect (takewhile null? '(1 2 ())) '())
        (check-expect (takewhile number? '(1 2 3 a 4 2)) '(1 2 3))
        (check-expect (takewhile symbol? '(a b c d e)) '(a b c d e))

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
        
        ;; Tests
        (check-expect (dropwhile number? '()) '())
        (check-expect (dropwhile number? '(1 2 3)) '())
        (check-expect (dropwhile symbol? '(1 2 3)) '(1 2 3))
        (check-expect (dropwhile symbol? '(a b 1 2 c d 3)) '(1 2 c d 3))
        (check-expect (dropwhile null? '(())) '())


;; 
;; Problem 4
;;

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
        ;; (is-ordered? xs) Given a list xs, returns a predicate which 
        ;; returns true if all the adjacent element pairs in xs satisfies the 
        ;; precedes? predicate, and false otherwise
        ([is-ordered? 
            (lambda (xs) 
                (if (|| (null? xs) (null? (cdr xs)))
                    #t 
                    (&& 
                        (precedes? (car xs) (cadr xs)) 
                        (is-ordered? (cdr xs) ))))])
            is-ordered?))

        ;; Tests 
        (check-assert (function? (ordered-by <)))
        (check-assert ((ordered-by >=) '()))
        (check-assert ((ordered-by >=) '(1)))
        (check-assert ((ordered-by <) '(1 2 3)))
        (check-assert (not ((ordered-by <) '(3 2 1))))
        (check-assert (not ((ordered-by <) '(1 2 3 2 1))))
        (check-assert (not ((ordered-by <) '(1 1))))
        (check-assert ((ordered-by <=) '(1 1)))

;;;; USING CLASSIC HIGHER-ORDER FUNCTIONS ;;;; 


;; 
;; Problem 5
;;

;; (max* xs) Given a non-empty list of numbers xs, the function returns 
;; the maximum value of the list 
(define max* (xs) (foldl max (car xs) (cdr xs)))
        
        ;; Tests
        (check-expect (max* '(1 2 3 4 5)) 5)
        (check-expect (max* '(1)) 1)
        (check-expect (max* '(3 2 1)) 3)
        (check-expect (max* '(-4 -100 -1 -42 -90)) -1)

;; (sum xs) Given a non-empty list of numbers xs, the function returns the 
;; sum of all of the values of the list 
(define sum (xs) (foldl + 0 xs))

        ;; Tests
        (check-expect (sum '(1)) 1)
        (check-expect (sum '(-1 -2 -3 -4)) -10)
        (check-expect (sum '(100 1 10 -1 1 -10 10 -100 100)) 111)
        (check-expect (sum '(1 2 3 4)) 10)
        (check-expect (sum '(0 0 0 0 0 0 )) 0)

;; (product xs) Given a non-empty list of numbers xs, the function returns the 
;; product of all of the value of the list
(define product (xs) (foldl * 1 xs))

        ;; Tests 
        (check-expect (product '(1 1 1 1 1 1 1)) 1)
        (check-expect (product '(1 2 3 4)) 24)
        (check-expect (product '(-1 -2 -3)) -6)
        (check-expect (product '(100 1000 1 0 -124 12)) 0)


;; 
;; Problem 6
;;

;; (append xs ys) Given two lists xs and ys, the function returns a list that 
;; is xs appended to ys 
(define append (xs ys) (foldr cons ys xs)) 

        ;; Tests 
        (check-expect (append '() '()) '())
        (check-expect (append '(1 2 3) '()) '(1 2 3))
        (check-expect (append '() '(1 2 3)) '(1 2 3))
        (check-expect (append '(1 2 3 4) '(5 6 7)) '(1 2 3 4 5 6 7))

;; (reverse xs) Given a list xs, the function returns a reversed version of xs
(define reverse (xs) (foldl cons '() xs))

        ;; Tests
        (check-expect (reverse '()) '())
        (check-expect (reverse '(1)) '(1))
        (check-expect (reverse '(1 2 3 4)) '(4 3 2 1))


;; 
;; Problem 7
;;

;; (map f xs) Given a single-argument function f and a list of inputs for the 
;; the function xs, the function returns the list of the results of running 
;; f on each element of xs 
(define map (f xs) 
    (foldr 
        (lambda (x acc) (cons (f x) acc)) 
        '() 
        xs ))

        ;; Tests 
        (check-expect (map null? '()) '())
        (check-expect (map null? '(())) '(#t))
        (check-expect (map number? '(1 2 3 a b c 4)) '(#t #t #t #f #f #f #t))
        (check-expect (map (lambda (x) (* x x)) '(1 2 3)) '(1 4 9))

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

        ;; Tests
        (check-expect (filter null? '()) '())
        (check-expect (filter null? '(())) '(()))
        (check-expect (filter number? '(a b c)) '())
        (check-expect (filter symbol? '(1 a 2 b 3 c)) '(a b c))
        (check-expect (filter symbol? '(a b c)) '(a b c))

;; (exists? p? xs) Given a predicate p? and a list of values that work on the 
;; predicate xs, the function returns true if there exists an element in the 
;; list which satisfies the predicate, and false otherwise 
(define exists? (p? xs) 
    (foldr 
        (lambda (x acc) (|| (p? x) acc))
        #f 
        xs ))

        ;; Tests
        (check-assert (not (exists? null? '())))
        (check-assert (exists? boolean? '(#t)))
        (check-assert (exists? null? '(1 2 3 () a b c)))
        (check-assert (not (exists? number? '(a b c))))
        (check-assert (exists? symbol? '(a b c)))

;; (all? p? xs) Given a predicate p? and a list of values that work on the 
;; predicate xs, the function returns true if all elements of the list satisfy
;; the predicate, and false otherwise
(define all? (p? xs) 
    (foldr
        (lambda (x acc) (&& (p? x) acc))
        #t 
        xs ))

        ;; Tests
        (check-assert (all? null? '()))
        (check-assert (all? boolean? '(#t)))
        (check-assert (not (all? number? '(1 2 3 a))))
        (check-assert (all? symbol? '(a b c)))
        (check-assert (not (all? number? '(a b c))))


;;;; FUNCITONS AS SETS ;;; 


;; 
;; Problem 8
;;

(val empty-set (lambda (x) #f))
(define member? (x s) (s x))

;; (evens x) A set which contains all the even integers, and given a value x,
;; returns true if it is in the set and false otherwise
(val evens 
    (lambda (x) (&& (number? x) (= 0 (mod x 2)))))

        ;; Tests
        (check-assert (member? 0 evens))
        (check-assert (member? 2 evens))
        (check-assert (not (member? 1 evens)))
        (check-assert (not (member? 'a evens)))

;; (two-digits x) A set which contains all the 2-digit positive integers, and 
;; given a value x, returns true if it is in the set and false otherwise
(val two-digits 
    (lambda (x) (&& (number? x) (&& (> x 9) (< x 100)))))

        ;; Tests
        (check-assert (member? 99 two-digits))
        (check-assert (member? 10 two-digits))
        (check-assert (member? 69 two-digits))
        (check-assert (not (member? 1 two-digits)))
        (check-assert (not (member? 142 two-digits)))
        (check-assert (not (member? 'ten two-digits)))

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
        (lambda (y) (|| (equal? y x) (member? y s))) ))

        ;; Tests
        (check-assert (member? 9 (add-element 9 evens)))
        (check-assert (member? 8 (add-element 9 evens)))
        (check-assert (member? 7 (add-element 6 (add-element 7 empty-set))))
        (check-assert (not (member? 9 (add-element 11 evens))))

;; (union s1 s2) Given two sets s1 and s2, the function returns a set which is 
;; union of the two sets s1 and s2 

;; laws 
;;      (member? x (union s1 s2)) == (|| (member? x s1) (member? x s2))
(define union (s1 s2) 
    (lambda (x) (|| (member? x s1) (member? x s2)))) 

        ;; Tests
        (check-assert (member? 2 (union evens two-digits)))
        (check-assert (member? 37 (union evens two-digits)))
        (check-assert (member? 22 (union evens two-digits)))
        (check-assert (not (member? 5 (union evens two-digits))))

;; (inter s1 s2) Given two sets s1 and s2, the function returns a set which is 
;; the intersection of the two sets s1 and s2

;; laws 
;;      (member? x (inter s1 s2)) == (&& (member? x s1) (member? x s2))
(define inter (s1 s2)
    (lambda (x) (&& (member? x s1) (member? x s2))))

        ;; Tests
        (check-assert (member? 22 (inter evens two-digits)))
        (check-assert (not (member? 21 (inter evens two-digits))))
        (check-assert (not (member? 2 (inter evens two-digits))))
        (check-assert (not (member? 153 (inter evens two-digits))))

;; (diff s1 s2) Given two sets s1 and s2, the function returns a set which is 
;; the difference of s1 - s2; in other words, it is the set of elements of s1
;; which are not in s2 

;; laws 
;;      (member? x (diff s1 s2)) == (&& (member? x s1) (not (member? x s2)))
(define diff (s1 s2) 
    (lambda (x) (&& (member? x s1) (not (member? x s2)))))
    
        ;; Tests
        (check-assert (member? 2 (diff evens two-digits)))
        (check-assert (not (member? 24 (diff evens two-digits))))
        (check-assert (not (member? 21 (diff evens two-digits))))
        (check-assert (not (member? 24 (diff two-digits evens))))
        (check-assert (member? 21 (diff two-digits evens)))
