
;; isZero and value tests
(check-assert ((Natural fromSmall: 0) isZero))
(check-assert (((Natural fromSmall: 1) isZero) not))
(
    check-print
    (DebugNat of: (Natural fromSmall: 5))
    0,1,0,1
)
(
    check-print
    (DebugNat of: (Natural fromSmall: 0))
    0
)
(
    check-print
    (DebugNat of: (Natural fromSmall: (Natural base)))
    0,1,0
)
(
    check-print
    (DebugNat of: (Natural fromSmall: ((Natural base) * (Natural base))))
    0,1,0,0
)
(
    check-print
    (DebugNat of: (Natural fromSmall: 2147483647))
    0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
)

;; Arithmetic tests
    ;; Type checks
(
    check-assert 
    (((Natural fromSmall: 0) divBase)
        isKindOf:
        NatZero)
)
(
    check-assert 
    (((Natural fromSmall: 0) timesBase)
        isKindOf:
        NatZero)
)
(
    check-assert 
    (((Natural fromSmall: 0) modBase)
        isKindOf:
        SmallInteger)
)
(
    check-assert 
    (((Natural fromSmall: 1) divBase)
        isKindOf:
        NatZero)
)
(
    check-assert 
    (((Natural fromSmall: 1) timesBase)
        isKindOf:
        NatNonzero)
)
(
    check-assert 
    (((Natural fromSmall: 1) modBase)
        isKindOf:
        SmallInteger)
)
(
    check-assert 
    (((Natural fromSmall: (Natural base)) divBase)
        isKindOf:
        NatNonzero)
)
(
    check-assert 
    (((Natural fromSmall: (Natural base)) timesBase)
        isKindOf:
        NatNonzero)
)
(
    check-assert 
    (((Natural fromSmall: (Natural base)) modBase)
        isKindOf:
        SmallInteger)
)
    ;; Value checks
(
    check-print 
    (DebugNat of: ((Natural fromSmall: 0) divBase))
    0
)
(
    check-print 
    (DebugNat of: ((Natural fromSmall: 0) timesBase))
    0
)
(
    check-expect
    ((Natural fromSmall: 0) modBase)
    0
)
(
    check-print 
    (DebugNat of: ((Natural fromSmall: 1) divBase))
    0
)
(
    check-print 
    (DebugNat of: ((Natural fromSmall: 1) timesBase))
    0,1,0
)
(
    check-expect
    ((Natural fromSmall: 1) modBase)
    1
)
(
    check-print 
    (DebugNat of: ((Natural fromSmall: (Natural base)) divBase))
    0,1
)
(
    check-print 
    (DebugNat of: ((Natural fromSmall: (Natural base)) timesBase))
    0,1,0,0
)
(
    check-expect
    ((Natural fromSmall: (Natural base)) modBase)
    0
)

;; + Tests
(
    check-print
    (DebugNat of: ((Natural fromSmall: 1) + (Natural fromSmall: 1)))
    0,1,0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: 0) + (Natural fromSmall: 0)))
    0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base))))
    0,1,0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0)))
    0,1,0
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 2147483647) + (Natural fromSmall: 2147483647)))
    0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: 104) + (Natural fromSmall: 12)))
    0,1,1,1,0,1,0,0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0)))
    0,1,0
)
(
    check-assert 
    (((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 1) isKindOf: 
        NatNonzero
    )
)
(
    check-assert 
    (((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 1) 0) isKindOf: 
        NatNonzero
    )
)
(
    check-assert 
    (((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 0) isKindOf: 
        NatZero
    )
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 0)
    )
    0
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 1)
    )
    0,1
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 1) 0)
    )
    0,1
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) plus:carry: 
            (Natural fromSmall: ((Natural base) - 1)) 
            1
        )
    )
    0,1,0
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: ((Natural base) - 1)) plus:carry: 
            (Natural fromSmall: 0) 
            1
        )
    )
    0,1,0
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) + (Natural fromSmall: 0))
    )
    0
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 1) + (Natural fromSmall: 0))
    )
    0,1
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) + (Natural fromSmall: 1))
    )
    0,1
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0))
    )
    0,1,0
)
(
    check-print
    (DebugNat of: 
        ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base)))
    )
    0,1,0
)

;; sdivmod tests
(
    check-print
    (DebugNat of: ((Natural fromSmall: 0) sdiv: 5))
    0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: (Natural base)) sdiv: 1))
    0,1,0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: (Natural base)) sdiv: (Natural base)))
    0,1
)
(
    check-expect
    ((Natural fromSmall: (Natural base)) smod: 1)
    0
)
(
    check-expect
    ((Natural fromSmall: ((Natural base) + 1)) smod: (Natural base))
    1
)
(
    check-expect
    ((Natural fromSmall: ((Natural base) * 100)) smod: (Natural base))
    0
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: 97) sdiv: 13))
    0,1,1,1
)
(
    check-expect
    ((Natural fromSmall: 97) smod: 13)
    6
)
(
    check-print
    (DebugNat of: ((Natural fromSmall: 50) sdiv: 256))
    0
)
(
    check-expect
    ((Natural fromSmall: 50) smod: 256)
    50
)

;; Decimal tests

    ;; isZero and value tests
(check-assert ((Natural fromSmall: 0) isZero))
(check-assert (((Natural fromSmall: 1) isZero) not))
(
    check-print
    (Natural fromSmall: 5)
    5
)
(
    check-print
    (DebugNat of: (Natural fromSmall: 0))
    0
)
(
    check-print
    (Natural fromSmall: (Natural base))
    2
)
(
    check-print
    (Natural fromSmall: ((Natural base) * (Natural base)))
    4
)
(
    check-print
    (Natural fromSmall: 2147483647)
    2147483647
)

    ;; + Tests
(
    check-print
    ((Natural fromSmall: 1) + (Natural fromSmall: 1))
    2
)
(
    check-print
    ((Natural fromSmall: 0) + (Natural fromSmall: 0))
    0
)
(
    check-print
    ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base)))
    2
)
(
    check-print
    ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0))
    2
)
(
    check-print
    ((Natural fromSmall: 2147483647) + (Natural fromSmall: 2147483647))
    4294967294
)
(
    check-print
    ((Natural fromSmall: 104) + (Natural fromSmall: 12))
    116
)
(
    check-print
    ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0))
    2
)
(
    check-print
    ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 0)
    
    0
)
(
    check-print
    ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 1)
    1
)
(
    check-print
    ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 1) 0)
    1
)
(
    check-print
    ((Natural fromSmall: 0) plus:carry: 
        (Natural fromSmall: ((Natural base) - 1)) 
        1
    )
    2
)
(
    check-print
    ((Natural fromSmall: ((Natural base) - 1)) plus:carry: 
        (Natural fromSmall: 0) 
        1
    )
    2
)
(
    check-print
    ((Natural fromSmall: 0) + (Natural fromSmall: 0))
    0
)
(
    check-print
    ((Natural fromSmall: 1) + (Natural fromSmall: 0))
    1
)
(
    check-print
    ((Natural fromSmall: 0) + (Natural fromSmall: 1))
    1
)
(
    check-print
    ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0))
    2
)
(
    check-print
    ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base)))
    2
)