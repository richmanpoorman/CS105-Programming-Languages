;; Starter code for SmallTalk assignement.
;; Author: Richard Townsend 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;             Exercise 1 classes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(class Natural
   [subclass-of Magnitude]

   (class-method fromSmall: (anInteger) 
      ((anInteger = 0) ifTrue:ifFalse: 
         {((NatZero new) validated)}
         {((
            self first:rest: 
              (anInteger mod: (Natural base))
              (Natural fromSmall: (anInteger div: (Natural base)))
            ) validated)
          }
      )
    )

   
   (class-method base () 2048) ; private ;; TODO: CHANGE THE BASE

   ; private methods suggested from textbook (page 672)
   (method modBase () (self subclassResponsibility)) 
   (method divBase () (self subclassResponsibility)) 
   (method timesBase () (self subclassResponsibility)) 
   (method compare:withLt:withEq:withGt: (aNatural ltBlock eqBlock gtBlock) 
      (self subclassResponsibility)) 
   (method plus:carry: (aNatural c) (self subclassResponsibility)) 
   (method minus:borrow: (aNatural c) (self subclassResponsibility)) 

   (method timesDigit:plus: (d r) (self subclassResponsibility)) ; private

   (method = (aNatural) 
    (self compare:withLt:withEq:withGt: 
      aNatural
      {false}
      {true}
      {false}
    )
   )
   (method < (aNatural) 
    (self compare:withLt:withEq:withGt: 
      aNatural
      {true}
      {false}
      {false}
    )
   )

   (method + (aNatural)
    (self plus:carry: aNatural 0)
   )
   (method * (aNatural) (self subclassResponsibility))
   (method subtract:withDifference:ifNegative: (aNatural diffBlock exnBlock)
      ( (self < aNatural) ifTrue:ifFalse:
        {(exnBlock value)}
        {(diffBlock value: (self minus:borrow: aNatural 0))}
      ) 
   )

   (method sdivmod:with: (n aBlock) (self subclassResponsibility))

   (method decimal () 
      [locals list x]
      (set list (List new))
      (set x self)
      ({(x isZero)} whileFalse: 
          {(x sdivmod:with: 
            10
            [block (q r)
              (list addFirst: r) 
              (set x q)
            ]
          )}
      )
      ((list isEmpty) ifTrue: 
        {(list addFirst: 0)}
      )
      list 
   )
   (method isZero  () (self subclassResponsibility))

   ; methods that are already implemented for you
   (method - (aNatural)
      (self subtract:withDifference:ifNegative:
            aNatural
            [block (x) x]
            {(self error: 'Natural-subtraction-went-negative)}))
   (method sdiv: (n) (self sdivmod:with: n [block (q r) q]))
   (method smod: (n) (self sdivmod:with: n [block (q r) r]))
   (method print () ((self decimal) do: [block (x) (x print)]))

   ;private methods for testing
   (method validated ()
    ((self invariant) ifFalse:
      {(self printrep)
       (self error: 'invariant-violation)})
    self)
   (method compare-symbol: (aNat)
    (self compare:withLt:withEq:withGt: aNat {'LT} {'EQ} {'GT}))

    (class-method first:rest: (anInteger aNatural) 
      ( ((aNatural isZero) and: {(anInteger = 0)}) ifTrue:ifFalse:
        {(aNatural validated)}
        {(((NatNonzero new) first:rest: anInteger aNatural) validated)}
      )
    )
)

; Represents a 0 natural number
(class NatZero
  [subclass-of Natural]
  (method invariant () true) ;; private

  (method timesDigit:plus: (d r) (Natural fromSmall: r)) ; private

  ;; for debugging
  (method printrep () (0 print))

  ;; EXERCISE 1
  (method isZero () true)
  (method divBase () self) 
  (method modBase () 0)
  (method timesBase () self)
  (method * (aNatural) self)
  (method sdivmod:with: (aSmallInteger aBlock)
    (aBlock value:value: self 0)
  )
  (method compare:withLt:withEq:withGt: (aNatural ltBlock eqBlock gtBlock)
    ((aNatural isZero) ifTrue:ifFalse:
      eqBlock
      ltBlock
    )
  )
  (method plus:carry: (aNatural c)
    ((aNatural isZero) ifTrue:ifFalse:
      {(Natural fromSmall: c)}
      {(aNatural plus:carry: self c)}
    )
  )
  (method minus:borrow: (aNatural c)
    (((aNatural isZero) and: {(c = 0)}) ifTrue:ifFalse:
      {self}
      {(self error: 'subratract-from-zero)}
    )
  )
)

; Represents a natural number greater than 0
(class NatNonzero
  [subclass-of Natural]
  [ivars m d] ; a non-zero natural number is of the form d + m * b, where d
              ; is an integer representing a digit of base b, and m is a natural
              ; number

  (method invariant () (((d < (Natural base)) & (d >= 0)) &  ;; private
                       (((m isZero) & (d = 0)) not)))

  ; addition with a carry bit
  (method plus:carry: (aNatural c) [locals sum least cout]
     (set sum ((d + (aNatural modBase)) + c))
     (set least (sum mod: (Natural base)))
     (set cout  (sum div: (Natural base)))
     (NatNonzero first:rest: least (m plus:carry: (aNatural divBase) cout)))
      
  ; subtraction with a borrow bit
  (method minus:borrow: (aNatural b) [locals diff least bout]
     (set diff (d - ((aNatural modBase) + b)))
     ((diff < 0) ifTrue:ifFalse:
         {(set diff (diff + (Natural base)))
          (set bout 1)}
         {(set bout 0)})
     (NatNonzero first:rest: diff (m minus:borrow: (aNatural divBase) bout)))

  ; multiplication
  (method * (aNatural) [locals d1 d2 m1 m2]
     ; simple method; fastest; based on this law:
     ;   (d + b * m) * n == (d * n) + b * (m * n)
     ((aNatural timesDigit:plus: d 0) + ((m * aNatural) timesBase)))

  (method timesDigit:plus: (dig r) ; private, answers self * d + r
      [locals pp]
      (set pp ((d * dig) + r))
      (NatNonzero first:rest: (pp mod: (Natural base))
                  (m timesDigit:plus: dig (pp div: (Natural base)))))
  
  ;; debugging method
  (method printrep () (m printrep) (', print) (d print))

  ;; EXERCISE 1 
  (method isZero () false)
  (method first:rest: (anInteger aNatural)
    (set m aNatural)
    (set d anInteger)
    (self validated))
  (method divBase () m) ;; TODO: SET VALUE TO m
  (method modBase () d)
  (method timesBase () 
    (NatNonzero first:rest: 0 self))
  (method sdivmod:with: (v k) 
    (m sdivmod:with: 
      v 
      [block (q r) 
        (k value:value: 
          (NatNonzero first:rest: 
            (((r * (Natural base)) + d) div: v)
            q
          )
          (((r * (Natural base)) + d) mod: v)
        )
      ]
    )
  )
  
  (method compare:withLt:withEq:withGt: (aNatural ltBlock eqBlock gtBlock)
    (m compare:withLt:withEq:withGt: (aNatural divBase)
      ltBlock 
      {(
        (d = (aNatural modBase)) ifTrue:ifFalse:
          eqBlock
          {(
            (d < (aNatural modBase)) ifTrue:ifFalse:
              ltBlock 
              gtBlock
          )}
      )}
      gtBlock
    )
  )
)

; For testing naturals
(class DebugNat
  [subclass-of Object]
  [ivars nat] ; a natural number
  (class-method of: (aNat) ((self new) init: aNat))
  (method init: (n) (set nat n) self) ; private
  (method print () (nat printrep))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Put your unit tests for Exercise 1 here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;             Exercise 2 classes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(class LargeInteger
  [subclass-of Integer]
  [ivars magnitude]

  (class-method withMagnitude: (aNatural)
      ((self new) magnitude: aNatural))
  (method magnitude: (aNatural) ; private, for initialization
      (set magnitude aNatural)
      self)

  (method magnitude () magnitude)

  (class-method fromSmall: (anInteger)
     ((anInteger isNegative) ifTrue:ifFalse: 
        {(((self fromSmall: 1) + (self fromSmall: ((anInteger + 1) negated)))
          negated)}
        {((LargePositiveInteger new) magnitude: 
                 (Natural fromSmall: anInteger))}))
  (method isZero () (magnitude isZero))
  (method = (anInteger) ((self - anInteger)     isZero))
  (method < (anInteger) ((self - anInteger) isNegative))

  (method div: (n) (self sdiv: n))
  (method mod: (n) (self smod: n))

  (method sdiv: (n) (self subclassResponsibility))
  (method smod: (n) (self - ((LargeInteger fromSmall: n) * (self sdiv: n))))
)

; Represents a positive integer
(class LargePositiveInteger
  [subclass-of LargeInteger]

  (method print ()
    ( (self isZero) ifTrue:ifFalse:
      {(0 print)}
      {
        ('+ print)
        ((self magnitude) print)
      }
    )
  )

  (method isNegative () false)
  (method isStrictlyPositive () ((self isZero) not))
  (method isNonnegative() ((self isZero) or: {(self isStrictlyPositive)}))
  (method negated () (LargeNegativeInteger withMagnitude: (self magnitude)))
  (method * (aNatural) (aNatural multiplyByLargePositiveInteger: self))
  (method multiplyByLargePositiveInteger: (aNatural)
    (LargePositiveInteger withMagnitude: 
      ((aNatural magnitude) * (self magnitude))
    )
  )
  (method multiplyByLargeNegativeInteger: (aNatural)
    (LargeNegativeInteger withMagnitude: 
      ((aNatural magnitude) * (self magnitude))
    )
  )


  ;; short division (already implemented for you)
  (method sdiv: (anInteger)
    ((anInteger isStrictlyPositive) ifTrue:ifFalse: 
       {(LargePositiveInteger withMagnitude:  (magnitude sdiv: anInteger))}
       {((((self - (LargeInteger fromSmall: anInteger)) -
                                                  (LargeInteger fromSmall: 1))
             sdiv: (anInteger negated))
            negated)}))
)

;; Represents a negative integer
(class LargeNegativeInteger
  [subclass-of LargeInteger]


  (method isNegative () ((self isZero) not))
  (method isStrictlyPositive () false)
  (method isNonnegative() (self isZero))
  (method negated () (LargePositiveInteger withMagnitude: (self magnitude)))
  (method * (aNatural) (aNatural multiplyByLargeNegativeInteger: self))
  (method multiplyByLargePositiveInteger: (aNatural)
    (LargeNegativeInteger withMagnitude: 
      ((aNatural magnitude) * (self magnitude))
    )
  )
  (method multiplyByLargeNegativeInteger: (aNatural)
    (LargePositiveInteger withMagnitude: 
      ((aNatural magnitude) * (self magnitude))
    )
  )

  (method print ()
    ( (self isZero) ifTrue:ifFalse:
      {(0 print)}
      {
        ('- print)
        ((self magnitude) print)
      }
    )
  )

  ;; short division (already implemented for you)
  (method sdiv: (anInteger)
    ((self negated) sdiv: (anInteger negated)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Put your unit tests for Exercise 2 here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(val four (LargePositiveInteger withMagnitude: 4))
(val neg-four (LargeNegativeInteger withMagnitude: 4))