(begin (println 4) (println 5) (* 4 5));

(val x 3)  
(let ([x 4] [y x]) y)

(let* ([x 4] [y x]) y)

(val y 4)  
(let ([x y] [y x]) y)

;; ;; USED AS HELPER FOR FIND-ARG-MAX FOR TAIL-RECURSION

;; (arg-max f xs currMax) Given a single parameter function f that returns a
;; number,a list of inputs xs that work for f, and the current input from the
;; initial list that gives the the highest value when evaluating with f, the
;; function returns the element in xs which yields the highest value when 
;; evaluating as  a parameter for f; Note that this function is used as a 
;; helper for find-arg-max in order to add a closure to the parameters,
;; and the default input for currMax should be the first element of the 
;; initial list (as if the rest is empty, it is assumed to be the best)

;; laws
;;      (arg-max f '() currMax) == currMax
;;      (arg-max f (cons x xs) currMax), where (f currMax) < (f x) ==
;;          (arg-max f xs x)
;;      (arg-max f (cons x xs) currMax), where (f currMax) >= (f x) ==
;;          (arg-max f xs currMax)
;; ...
;; If we are at the end of the list, return the current maximum found
;; If x is better than the current max, store that as the new max
;; If x is not better than the current max, keep the current max

(define find-arg-max (f xs currMax)
    (if (null? xs) 
        currMax
        (if (< (f currMax) (f (car xs)))
            (find-arg-max f (cdr xs) (car xs))
            (find-arg-max f (cdr xs) (currMax)))))