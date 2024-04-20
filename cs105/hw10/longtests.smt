
;; isZero and value tests
(check-assert ((Natural fromSmall: 0) isZero))
(check-assert (((Natural fromSmall: 1) isZero) not))
(
    check-print
    (DebugNat of: (Natural fromSmall: 5))
    0,5
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
    (DebugNat of: (Natural fromSmall: 999))
    0,9,9,9
)
(
    check-print
    (DebugNat of: (Natural fromSmall: 2147483647))
    0,2,1,4,7,4,8,3,6,4,7
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
    check-assert 
    ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 1)
)
(n plus:carry: (Natural fromSmall: 0) 1)
(n plus:carry: (Natural fromSmall: 1) 0)