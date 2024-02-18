(val fail-queens
        (lambda () 'no-solution ))

(val succ-queens
        (lambda (placed resume) 'N-queens-success))

(define N-queens (N fail succ)
        (letrec

        ;; 
        ;; Laws
        ;; 
        ;; (place-queens placed 0 safe f s) == (s placed f)
        ;; (place-queens placed (+ m 1) '() f s) == (f)
        ;; (place-queens placed (+ m 1) (cons y ys) f s) == 
        ;;      (place-queens (cons y placed) m (prune-squares y (cons y ys)) 
        ;;              (lambda () (place-queens placed (+ m 1) ys f s) ) 
        ;;              s
        ;;      )
        ([place-queens
                (lambda (placed left-to-place safe f s)
                        (if (= 0 left-to-place) 
                                (s placed f)
                                (if (null? safe)
                                        (f)
                                        (place-queens  
                                                (cons (car safe) placed) 
                                                (- left-to-place 1)
                                                (prune-squares 
                                                        (car safe) safe)
                                                (lambda () 
                                                        (place-queens 
                                                                placed 
                                                                left-to-place
                                                                (cdr safe)
                                                                f
                                                                s 
                                                s )))))

                )])
        (place-queens '() N (empty-board N) fail succ)))

(define num-solutions (N)
        (N-queens N (lambda () 0) (lambda (placed resume) (+ 1 (resume)))))
