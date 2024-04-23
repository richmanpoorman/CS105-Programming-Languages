
;; isZero and value tests
(check-assert ((Natural fromSmall: 0) isZero))
(check-assert (((Natural fromSmall: 1) isZero) not))
;; (
;;     check-print
;;     (DebugNat of: (Natural fromSmall: 5))
;;     0,1,0,1
;; )
;; (
;;     check-print
;;     (DebugNat of: (Natural fromSmall: 0))
;;     0
;; )
;; (
;;     check-print
;;     (DebugNat of: (Natural fromSmall: (Natural base)))
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: (Natural fromSmall: ((Natural base) * (Natural base))))
;;     0,1,0,0
;; )
;; (
;;     check-print
;;     (DebugNat of: (Natural fromSmall: 2147483647))
;;     0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
;; )
(
    check-error
    (Natural fromSmall: -1)
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
;; (
;;     check-print 
;;     (DebugNat of: ((Natural fromSmall: 0) divBase))
;;     0
;; )
;; (
;;     check-print 
;;     (DebugNat of: ((Natural fromSmall: 0) timesBase))
;;     0
;; )
;; (
;;     check-expect
;;     ((Natural fromSmall: 0) modBase)
;;     0
;; )
;; (
;;     check-print 
;;     (DebugNat of: ((Natural fromSmall: 1) divBase))
;;     0
;; )
;; (
;;     check-print 
;;     (DebugNat of: ((Natural fromSmall: 1) timesBase))
;;     0,1,0
;; )
(
    check-expect
    ((Natural fromSmall: 1) modBase)
    1
)
;; (
;;     check-print 
;;     (DebugNat of: ((Natural fromSmall: (Natural base)) divBase))
;;     0,1
;; )
;; (
;;     check-print 
;;     (DebugNat of: ((Natural fromSmall: (Natural base)) timesBase))
;;     0,1,0,0
;; )
(
    check-expect
    ((Natural fromSmall: (Natural base)) modBase)
    0
)

;; + Tests
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 1) + (Natural fromSmall: 1)))
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 0) + (Natural fromSmall: 0)))
;;     0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;          ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base))))
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;          ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0)))
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 2147483647) + (Natural fromSmall: 2147483647)))
;;     0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 104) + (Natural fromSmall: 12)))
;;     0,1,1,1,0,1,0,0
;; )
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 
;;          (Natural base)) + (Natural fromSmall: 0)))
;;     0,1,0
;; )
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
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 0)
;;     )
;;     0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 0) 1)
;;     )
;;     0,1
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) plus:carry: (Natural fromSmall: 1) 0)
;;     )
;;     0,1
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) plus:carry: 
;;             (Natural fromSmall: ((Natural base) - 1)) 
;;             1
;;         )
;;     )
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: ((Natural base) - 1)) plus:carry: 
;;             (Natural fromSmall: 0) 
;;             1
;;         )
;;     )
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) + (Natural fromSmall: 0))
;;     )
;;     0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 1) + (Natural fromSmall: 0))
;;     )
;;     0,1
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) + (Natural fromSmall: 1))
;;     )
;;     0,1
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0))
;;     )
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: 
;;         ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base)))
;;     )
;;     0,1,0
;; )

;; sdivmod tests
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 0) sdiv: 5))
;;     0
;; )
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: (Natural base)) sdiv: 1))
;;     0,1,0
;; )
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: (Natural base)) sdiv: (Natural base)))
;;     0,1
;; )
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
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 97) sdiv: 13))
;;     0,1,1,1
;; )
(
    check-expect
    ((Natural fromSmall: 97) smod: 13)
    6
)
;; (
;;     check-print
;;     (DebugNat of: ((Natural fromSmall: 50) sdiv: 256))
;;     0
;; )
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
;; (
;;     check-print
;;     (DebugNat of: (Natural fromSmall: 0))
;;     0
;; )
(
    check-print
    (Natural fromSmall: (Natural base))
    2048
)
(
    check-print
    (Natural fromSmall: ((Natural base) * (Natural base)))
    4194304
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
    2048
)
(
    check-print
    ((Natural fromSmall: (Natural base)) + (Natural fromSmall: 0))
    2048
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
    2048
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
    2048
)
(
    check-print
    ((Natural fromSmall: ((Natural base) - 1)) plus:carry: 
        (Natural fromSmall: 0) 
        1
    )
    2048
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
    2048
)
(
    check-print
    ((Natural fromSmall: 0) + (Natural fromSmall: (Natural base)))
    2048
)

;; Test Comparison 
    ;; Types are correct
(
    check-print 
    ((Natural fromSmall: 0) compare-symbol: (Natural fromSmall: 0))
    EQ 
)
(
    check-print 
    ((Natural fromSmall: ((Natural base) * (Natural base))) compare-symbol: 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
    EQ
)
(
    check-print 
    ((Natural fromSmall: 0) compare-symbol: 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
    LT
)
(
    check-print 
    ((Natural fromSmall: 1) compare-symbol: 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
    LT
)
(
    check-print 
    ((Natural fromSmall: (Natural base)) compare-symbol: 
        (Natural fromSmall: ((Natural base) + 1)))
    LT
)
(
    check-print 
    ((Natural fromSmall: ((Natural base) * (Natural base))) compare-symbol: 
        (Natural fromSmall: 0)
    )
    GT
)
(
    check-print 
    ((Natural fromSmall: ((Natural base) * (Natural base))) compare-symbol: 
        (Natural fromSmall: 1)
    )
    GT
)
(
    check-print 
    ((Natural fromSmall: 3) compare-symbol: (Natural fromSmall: 2))
    GT
)
    ;; Assertions
(
    check-assert
    ((Natural fromSmall: 0) = (Natural fromSmall: 0))
)
(
    check-assert
    ((Natural fromSmall: ((Natural base) * (Natural base))) = 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
)
(
    check-assert
    ((Natural fromSmall: 0) < 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
)
(
    check-assert
    ((Natural fromSmall: 1) < 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
)
(
    check-assert
    ((Natural fromSmall: 2) < (Natural fromSmall: 3))
)
(
    check-assert
    ((Natural fromSmall: ((Natural base) * (Natural base))) > 
        (Natural fromSmall: 0)
    )
)
(
    check-assert
    ((Natural fromSmall: ((Natural base) * (Natural base))) > 
        (Natural fromSmall: 1)
    )
)
(
    check-assert
    ((Natural fromSmall: 3) > (Natural fromSmall: 2))
)

;; Subtraction
(
    check-print
    ((Natural fromSmall: 0) - (Natural fromSmall: 0))
    0
)
(
    check-print
    ((Natural fromSmall: ((Natural base) * (Natural base))) - 
        (Natural fromSmall: 0)
    )
    4194304
)
(
    check-error
    ((Natural fromSmall: 0) - 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
)
(
    check-print 
    ((Natural fromSmall: 100) - (Natural fromSmall: 100))
    0
)
(
    check-print 
    ((Natural fromSmall: 31) - (Natural fromSmall: 12))
    19
)
(
    check-error 
    ((Natural fromSmall: 15) - 
        (Natural fromSmall: ((Natural base) * (Natural base)))
    )
)
(
    check-print
    ((Natural fromSmall: 7) - (Natural fromSmall: 5))
    2
)
(
    check-print
    ((Natural fromSmall: 3) - (Natural fromSmall: 2))
    1
)
(
    check-error 
    ((Natural fromSmall: 2) - (Natural fromSmall: 3))
)

;; Multiplication test
(
    check-print
    ((Natural fromSmall: 2147483647) * (Natural fromSmall: 2147483647))
    4611686014132420609
)
(
    check-print
    ((Natural fromSmall: 2147483647) * (Natural fromSmall: 0))
    0
)
(
    check-print
    ((Natural fromSmall: 0) * (Natural fromSmall: 2147483647))
    0
)
(
    check-print
    ((Natural fromSmall: 0) * (Natural fromSmall: 0))
    0
)
(
    check-print
    ((Natural fromSmall: 1) * (Natural fromSmall: 2147483647))
    2147483647
)
(
    check-print
    ((Natural fromSmall: 6) * (Natural fromSmall: 7))
    42
)
(Natural addSelector:withMethod: 'squared
  (compiled-method () (self * self)))
(Natural addSelector:withMethod: 'coerce:
  (compiled-method (i) (Natural fromSmall: i)))
(Natural addSelector:withMethod: 'raisedToInteger:
  (Number compiledMethodAt: 'raisedToInteger:))

(check-print ((Natural fromSmall: 10) raisedToInteger: 10) 10000000000)
(check-print ((Natural fromSmall:  9) raisedToInteger:  9)   387420489)
(check-print ((Natural fromSmall: 99) raisedToInteger: 99)   
  ;; result broken into multiple lines for readability; they must be rejoined
  369729637649726772657187905628805440595668764281741102430259972423552570455277523421410650010128232727940978889548326540119429996769494359451621570193644014418071060667659301384999779999159200499899)

;; EXERCISE 2:
;; Test sign
(
    check-assert 
    (((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 0)) isNegative) not)
)
(
    check-assert 
    (((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 1)) isNegative) not)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 0)) isNegative) not)
)
(
    check-assert 
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 1)) isNegative) 
)

(
    check-assert 
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 0)) isNonnegative)
)
(
    check-assert 
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 1)) isNonnegative)
)
(
    check-assert 
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 0)) isNonnegative)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 1)) isNonnegative) not)
)

(
    check-assert 
    (((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 0)) isStrictlyPositive) not)
)
(
    check-assert 
    ((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 1)) isStrictlyPositive)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 0)) isStrictlyPositive) not)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 1)) isStrictlyPositive) not)
)

(
    check-print
    (LargeNegativeInteger withMagnitude: (Natural fromSmall: 0))
    0
)
(
    check-print
    (LargePositiveInteger withMagnitude: (Natural fromSmall: 0))
    0
)
(
    check-print
    (LargeNegativeInteger withMagnitude: (Natural fromSmall: 1))
    -1
)
(
    check-print
    (LargePositiveInteger withMagnitude: (Natural fromSmall: 1))
    1
)

;; Negated
(
    check-assert 
    ((((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 0)) negated) isNegative) not)
)
(
    check-assert 
    (((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 1)) negated) isNegative)
)
(
    check-assert 
    ((((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 0)) negated) isNegative) not)
)
(
    check-assert 
    ((((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 1)) negated) isNegative) not)
)

(
    check-assert 
    (((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 0)) negated) isNonnegative)
)
(
    check-assert 
    ((((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 1)) negated) isNonnegative) not)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 0)) negated) isNonnegative)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 1)) negated) isNonnegative)
)

(
    check-assert 
    ((((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 0)) negated) isStrictlyPositive) not)
)
(
    check-assert 
    ((((LargePositiveInteger withMagnitude: 
        (Natural fromSmall: 1)) negated) isStrictlyPositive) not)
)
(
    check-assert 
    ((((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 0)) negated) isStrictlyPositive) not)
)
(
    check-assert 
    (((LargeNegativeInteger withMagnitude: 
        (Natural fromSmall: 1)) negated) isStrictlyPositive)
)

(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 0)) negated)
    0
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 0)) negated)
    0
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 1)) negated)
    1
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 1)) negated)
    -1
)
(
    check-print
    ((LargeInteger fromSmall: 0) negated)
    0
)

;; Multiplication Tests
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 0)) * 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 0)))
    0
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)) * 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)))
    4611686014132420609
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)) * 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)))
    -4611686014132420609
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)) * 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)))
    -4611686014132420609
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)) * 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)))
    4611686014132420609
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)) * 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 0)))
    0
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)) * 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 0)))
    0
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 5)) * 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 1)))
    -5
)

;; Addition tests
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 10)) + 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 10)))
    20
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 10)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 10)))
    -20
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 10)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 10)))
    0
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 1)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 10)))
    -9
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 10)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 1)))
    9
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 1)) + 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 10)))
    9
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 10)) + 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 1)))
    -9
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)) + 
        (LargePositiveInteger withMagnitude: (Natural fromSmall: 2147483647)))
    4294967294
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)))
    -4294967294
)
(
    check-print
    ((LargeNegativeInteger withMagnitude: (Natural fromSmall: 1)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)))
    -2147483648
)
(
    check-print
    ((LargePositiveInteger withMagnitude: (Natural fromSmall: 1)) + 
        (LargeNegativeInteger withMagnitude: (Natural fromSmall: 2147483647)))
    -2147483646
)

;; EXTRA 
(
    check-assert 
    ((Natural fromSmall: 0) isKindOf: Natural)
)