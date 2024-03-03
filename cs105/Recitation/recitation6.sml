(************************************************************************

Part 1: 

1. 
    a. Disagree, as the parethansis is used when a function is an input 
       as it means to "evaluate this first" 
    b. The function starts out curried, so calling it on one input DOES 
       return a function, but since you just give it the three chars, 
       it will use the functions in successive order, leading to the result
       looking like it takes 3 chars 
    c. Yes, as the first two are in a tuple, and the last one is curried 
2. 
    a. plum 
    b. peach 
    c. slice 
    d. apple 
    e. orange 
3. 
    a. pear 
    b. front 
    c. melon
    d. back
4. 
    a. star 
    b. grape
    c. kiwi

Part 2: 

datatype bit = ZEROBIT | ONEBIT
1. 
    datatype binary = ZB
                    | TP of binary * bit
2.
    fun eval_bit ZEROBIT = 0 
      | eval_bit ONEBIT  = 1
    fun int_of_binary ZB               = 0
      | int_of_binary (TP (bits, bit)) = 2 * int_of_binary bits + eval_bit bit
3. 
    a. BOOL false
    b. NUM 17 
    c. SYM "frog"
    d. SXS [SYM "COMP", NUM 105]
4.
    datatype uscheme_value = VBOOL     of bool 
                           | VNUM      of int 
                           | VSYM      of string
                           | VEMPTY
                           | VCONS     of uscheme_value * uscheme_value
                           | VFUNCTION of uscheme_value list -> uscheme_value
5. 
    ...
6. 
    fun sv_of_sx (BOOL x)        = VBOOL x
      | sv_of_sx (NUM  x)        = VNUM  x
      | sv_of_sx (SYM  x)        = VSYM  x
      | sv_of_sx (SXS [])        = VEMPTY
      | sv_of_sx (SXS (x :: xs)) = VCONS (sv_of_xs x, sv_of_xs (SXS xs))
************************************************************************)
