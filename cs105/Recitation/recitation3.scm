;; 1) x can be any ordinary S-expression (boolean, integer, symbol, list)
;;    s can be an empty list or a non-empty list

;; 2)
;; x-inputs::
;; boolean : #t
;; int     : 1234567890
;; symbol  : 'test
;; list    : '()
;; list    : '(1 2 3)

;; s-inputs::
;; empty-list: '()
;; nonempty-list: '(a b (c d))

;; laws for member?
;; (member? x '()) == #f 
;; (member? x (cons x ys)) == #t 
;; (member? x (cons y ys)) == (member? x ys), where x != y

;; laws for add-elem
;; (add-elem x '()) == (cons x '())
;; (add-elem x (cons x xs)) == (cons x xs)
;; (add-elem x (cons y ys)) == (cons y (add-elem x ys)), where x != y