;; Q1
(val squareList (lambda (ns) (map (lambda (n) (* n n) ) ns )))

;; Q2 
(val evenOdd (lambda (ns) (map (lambda (n) (= 0 (mod n 2))) ns)))

;; Q3 
;; The answer is the same, as min is an associative operation

;; Q4
;; They are not the same, as cons is NOT associative; the first will 
;; reverse the list , the second will make a copy of the list
;; It will happen because it will start accumulating from the left going right
;; vs accumulating from the right going left


(record frozen-dinner [protein starch vegetable dessert])
;; Q5
(val british-dinner
        (make-frozen-dinner 'meat-pi' 'mash' 'grilled-tomato' 'jaffa-cake'))

;; Q6
(val getDessert (lambda (ls) (map frozen-dinner-dessert ls)))

;; Q7
(val numDinners (lambda (ls) 
                        (foldl 
                                (lambda (x acc) 
                                        (if (frozen-dinner? x)
                                                (+ 1 acc)
                                                acc)
                                0
                                ls))))

;; Q8
(val empty-array
        (make-array 
                (lambda (index) #f)
                (lambda (index) (error 'NotInList))
                ))

;; Q9
(define array-update (a i v)
        (make-array 
                (lambda (index) 
                        (|| 
                                (= i index)
                                ((array-defined-at? a) index)))
                (lambda (index)
                        (if (= i index)
                                v 
                                ((array-at a) index))) 
                ))

;; Q10
(val squares 
        (make-array
                (lambda (index) 
                        #t)
                (lambda (index)
                        (* index index))
                ))
