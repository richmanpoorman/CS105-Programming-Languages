(val f (lambda () y))
(val y 10)
(f)

(val x #f)
(val is-scheme
(lambda () x))
(val x #t)
(is-scheme)