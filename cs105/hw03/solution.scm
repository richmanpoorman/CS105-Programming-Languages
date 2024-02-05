;;;;;;;;;;;;;;;;;;; COMP 105 SCHEME ASSIGNMENT ;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise 2


;; (prefix-of-list? xs ys) Given two lists xs and ys, the function returns true
;; if xs is the prefix of the list ys, and false otherwise; that is, if the
;; elements of xs match the starting elements of ys (in the same order)

;; Algebraic laws
;; (prefix-of-list? '() ys) == #t
;; (prefix-of-list? xs '()), where xs is not empty == #f
;; (prefix-of-list? (cons z zs) (cons w ws)), where z = w == 
;;      (prefix-of-list? zs ws)
;; (prefix-of-list? (cons z zs) (cons w ws)), where z != w == #f
(define prefix-of-list? (xs ys) 
    (if (null? xs)
        #t
        (if (null? ys) 
            #f 
            (if (equal? (car xs) (car ys))
                (prefix-of-list? (cdr xs) (cdr ys))
                #f ))))

        (check-assert (prefix-of-list? '() '())) 
        (check-assert (prefix-of-list? '() '(a b c)))
        (check-assert (prefix-of-list? '(a b c) '(a b c)))
        (check-assert (not (prefix-of-list? '(a b c) '(a b))))
        (check-assert (not (prefix-of-list? '(a b c) '(a a b c))))
        (check-assert (not (prefix-of-list? '(a b c) '(1 2 3))))

;; (contig-sublist? xs ys) Given two lists xs and ys, the function returns true
;; if xs is a contiguous subarray of ys, and false otherwise; xs is a 
;; contiguous subarray if there are two lists 'front' and 'back' (which may be
;; empty) such that ys = (append (append front xs) back)

;; laws (if you want to attempt them; they are optional for this problem):
;;   (contig-sublist? xs ys), where xs is the prefix of ys == #t
;;   (contig-sublist? xs '()), where xs is not empty == #f
;;   (contig-sublist? xs ys), where xs is not the prefix of ys == 
;;      (contig-sublist? xs (cdr ys))
;; If xs is a contiguous subarray of ys, then there must be a point of 
;; ys such that xs is the prefix of ys (given by removing 'front');
;; This means that we can try removing each start element and 
;; seeing if it is the prefix; if it is never the prefix, the ys = '()
;; which automatically makes xs in a failing state (unless xs = '())

(define contig-sublist? (xs ys)
    (if (prefix-of-list? xs ys) 
        #t 
        (if (null? ys)
            #f
            (contig-sublist? xs (cdr ys)))))

        
        (check-assert (contig-sublist? '() '()))
        (check-assert (contig-sublist? '() '(a b c)))
        (check-assert (not (contig-sublist? '(a b c) '())))
        (check-assert (contig-sublist? '(a b) '(1 a b 2)))
        (check-assert (contig-sublist? '(a b) '(a b 2)))
        (check-assert (not (contig-sublist? '(a b) '(1 2 3))))
        (check-assert (not (contig-sublist? '(a b) '(1 a 2 b 3))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise 3


;; (flatten xs) Given a list xs of ordinary S-expressions, the function returns
;; a copy of the list xswithout internal brackets; in other words, the function
;; returns a copy of  xs where lists inside of xs have their elements directly
;; in the copy

;; laws:
;;   (flatten '()) == '()
;;   (flatten (cons '() ys)) == (flatten ys) 
;;   (flatten (cons y ys)), where y is a non-empty list  == 
;;      (append (flatten y) (flatten ys)) 
;;   (flatten (cons y ys)), where y is not a list == (cons y (flatten ys))
;;   ...
;; If the list is empty, then flattening the list also produces an empty list
;; If the list element is not a list, then we can keep the element as is
;; If the list element is a list, then we need to flatten that list, then
;;  append it to the rest of the flattened list
;; Note that an extra rule where if the element itself is the null list, 
;;  we need an extra case, as to detect a list, we use pair?, but 
;;  '() is not a cons-cell

(define flatten (xs)
    (if (null? xs)
        '()
        (if (null? (car xs))
            (flatten (cdr xs))
            (if (pair? (car xs))
                (append (flatten (car xs)) (flatten (cdr xs)) )
                (cons (car xs) (flatten (cdr xs)) ) ))))
        
        (check-expect (flatten '()) '())
        (check-expect (flatten '(a b c)) '(a b c))
        (check-expect (flatten '(a (b c) d)) '(a b c d))
        (check-expect (flatten '((1 2 (3 4 (5 6) 7 8) 9 10 (11 12))))
            '(1 2 3 4 5 6 7 8 9 10 11 12))
        (check-expect (flatten '(1 2 3 () 4 5 () () (6 7 () (8) () (9 ()))))
            '(1 2 3 4 5 6 7 8 9))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise 4


;; (take n xs) Given a natural number n and a list xs, the function returns
;; a list with the first n elements of xs, or all of xs if the length of 
;; xs is less than or equal to n

;; laws:
;;   (take n '())         == '()
;;   (take 0 xs)          == '()
;;   (take n (cons y ys)), where n != 0 == (cons y (take (- n 1) ys))
;;   ...
;; If the list is empty, then we return an empty list
;; If there are no elements left to be taken, we also return nothing
;;      as we don't take the remaining parts of the list
;; Then, we take the front element, and get the n - 1 elements from the
;;      remainder of the list

(define take (n xs)
    (if (|| (null? xs) (= 0 n))
        '()
        (cons (car xs) (take (- n 1) (cdr xs)))))

        ;; replace next line with good check-expect or check-assert tests
        (check-expect (take 0 '(1 2 3)) '())
        (check-expect (take 10 '()) '())
        (check-expect (take 10 '(a b c)) '(a b c))
        (check-expect (take 5 '(1 2 3 4 5 6 7 8 9)) '(1 2 3 4 5))
        (check-expect (take 1 '(1)) '(1))



;; (drop n xs) Given a natural number n and a list xs, the function returns
;; a copy of xs with the first n elements removed, or an empty list if the
;; length if xs is less than or equal to n

;; laws:
;;   (drop n '()) == '()
;;   (drop 0 xs)  == xs
;;   (drop n (cons y ys)), where n != 0  == (drop (- n 1) ys)
;; ...
;; If the list is empty, then just return the empty list 
;; If we don't need to drop any, then just return what remains
;; Then, otherwise skip the element, and decrement how many left to remove

(define drop (n xs)
    (if (null? xs) 
        '()
        (if (= n 0) 
            xs
            (drop (- n 1) (cdr xs) ))))

        ;; replace next line with good check-expect or check-assert tests
        (check-expect (drop 0 '()) '())
        (check-expect (drop 10 '()) '())
        (check-expect (drop 0 '(1 2 3)) '(1 2 3))
        (check-expect (drop 5 '(1 2 3)) '())
        (check-expect (drop 5 '(1 2 3 4 5 6 7 8 9)) '(6 7 8 9))
        (check-expect (drop 1 '(1 2 3 4 5 6 7 8 9)) '(2 3 4 5 6 7 8 9))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise 5


;; (zip xs ys) Given two lists of equal length xs and ys, the function returns
;; a list with the same size of xs/ys whose elements are 2-length lists which
;; contain corresponding associated values in the two lists (aka it is a list
;; which contains the values of each list at each index) in the form of (x, y)
;; where x is from xs and y is the corresponding value from ys

;; laws:
;;   (zip '() ys) == '()
;;   (zip xs '()) == '()
;;   (zip (cons z zs) (cons w ws)) == 
;;      (cons (cons x (cons y '()) ) (zip zs ws))
;;   ...
;; If you hit the end of the list, return the empty list,
;; Otherwise, make a list of x and y, then add them to the list

(define zip (xs ys)
    (if (|| (null? xs) (null? ys)) 
        '()
        (cons 
            (cons (car xs) (cons (car ys) '()))
            (zip (cdr xs) (cdr ys) )))) ;; replace this line with good code

        ;; replace next line with good check-expect or check-assert tests
        (check-expect (zip '() '()) '())
        (check-expect (zip '(a) '(1)) '((a 1)))
        (check-expect (zip '(1 2 3) '(a b c)) '((1 a) (2 b) (3 c)))

;; (unzip ps) Given a list of 2-length lists (pairs) ps, the function returns
;; a pair (list of length 2) of lists containing the separate elements; in 
;; other words, the function returns a list of lists, the first list element
;; containing all of the first values of the lists in ps in order and the 
;; second list element containing all of the second values of the lists in ps
;; in the order that they appeared in

;; laws (if you want to attempt them; they are optional for unzip):
;;   (unzip '()) == '(() ())
;;   (unzip (cons (cons x (cons y '())) zs)) == 
;;      (cons
;;          (cons x (car (unzip zs)))
;;          (cons (cons y (cadr (unzip zs))) 
;;              '())
;;   ...
;; If the list given is empty, the return two empty lists
;; Otherwise, unpack the values of the first list into x, y and then get
;;      the rest of the list unpacked and add them

(define unzip (ps)
    (if (null? ps) 
        '(() ())
        (let* 
            ([nextLists (unzip (cdr ps))]
                [x      (caar  ps)]
                [y      (cadar ps)]
                [nextXs (car  nextLists)]
                [nextYs (cadr nextLists)]
                [xList  (cons x nextXs)]
                [yList  (cons y nextYs)])
            (cons xList (cons yList '() )))))

        ;; replace next line with good check-expect or check-assert tests
        (check-expect (unzip '()) '(() ()))
        (check-expect (unzip '((a b))) '((a) (b)))
        (check-expect (unzip '((1 2) (3 4) (5 6))) '((1 3 5) (2 4 6)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise 6




;; (arg-max f xs) Given a single parameter function f that returns a number
;; and a non-empty list of inputs xs that work for f, the function returns the
;; element in xs which yields the highest value when evaluating as a parameter
;; for f

;; laws:
;;   (arg-max f (cons x '())) == x
;;   (arg-max f (cons x xs)), where (f x) >= (f (arg-max f xs)) == x 
;;   (arg-max f (cons x xs)), where (f x) <  (f (arg-max f xs)) == 
;;      (arg-max f xs)
;; [optional notes about where laws come from, or difficulty, if any]

(define arg-max (f xs)
    (if (null? (cdr xs))
        (car xs)
        (let 
            ([nextArgMax (arg-max f (cdr xs))])
            (if (>= (f (car xs)) (f nextArgMax))
                (car xs)
                nextArgMax ))))

        ;; replace next line with good check-expect or check-assert tests
        (check-expect (arg-max car '((-15 a) (-14 b) (-18 c) (-22))) '(-14 b))
        (check-expect (arg-max car '((10 a) (0 b c) (22) (13 a b))) '(22))
        (check-expect (arg-max car '((1))) '(1))
(define square-negate (x) (- 0 (* x x)))
        (check-expect (arg-max square-negate '(1 -22 0 101 -5)) 0)

