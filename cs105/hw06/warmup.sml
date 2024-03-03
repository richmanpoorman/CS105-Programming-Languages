(*****************
    Name       : Matthew Wong 
    Assignment : Programming With ML
    File       : warmup.sml
*****************)

(*** Problem 1 ***)

(*****************************************************************************
    (mynull ls) Given a list ls, returns true if ls is empty, false otherwise 
        a' list -> bool 
*****************************************************************************)
fun mynull [] = true 
  | mynull _  = false

    (* Unit Test *)
val () =
    Unit.checkAssert "[] is null"
    (fn () => mynull [])
val () = 
    Unit.checkAssert "[1] is not null" 
    (fn () => not (mynull [1]))
val () = 
    Unit.checkAssert "[1 2 3 4 5] is not null" 
    (fn () => not (mynull [1, 2, 3, 4, 5]))

(*** Problem 2 ***)

(*****************************************************************************
    (reverse ls) Given a list ls, returns the reversed version of the list 
        a' list -> a'list
*****************************************************************************)
fun reverse ls = foldl (fn (x, acc) => x :: acc) [] ls

(* (int list) string buffer for unit testing *)
val int_list_toString = Unit.listString Unit.intString
(* Unit Test *)
val () =
   Unit.checkExpectWith int_list_toString "reversing empty"
   (fn () => reverse [])
   []
val () = 
    Unit.checkExpectWith int_list_toString "reversing single element" 
    (fn () => reverse [1]) 
    [1] 
val () =
    Unit.checkExpectWith int_list_toString "reversing odd count"
    (fn () => reverse [1, 2, 3])
    [3, 2, 1]
val () =
    Unit.checkExpectWith int_list_toString "reversing even count"
    (fn () => reverse [1, 2, 3, 4])
    [4, 3, 2, 1]

(*****************************************************************************
    (minlist ls) Given a non-empty list of integers ls, returns the min value 
        int list -> int
*****************************************************************************)
fun minlist []            = raise Match 
  | minlist (first :: ls) = foldl Int.min first ls

(* Unit Test *)
val () =
   Unit.checkExpectWith Unit.intString "smallest of singleton"
   (fn () => minlist [1])
   1
val () = 
    Unit.checkExnWith Unit.intString "empty list" 
    (fn () => minlist []) 
val () = 
    Unit.checkExpectWith Unit.intString "first minimum" 
    (fn () => minlist [1, 2, 3, 4])
    1 
val () = 
    Unit.checkExpectWith Unit.intString "last minimum" 
    (fn () => minlist [4, 3, 2, 1])
    1 
val () = 
    Unit.checkExpectWith Unit.intString "middle minimum" 
    (fn () => minlist [4, 3, 2, 1, 2, 3, 4])
    1 

(*** Problem 3 ***)
(*****************************************************************************
    (Mismatch) An error representing a bad input where the sizes of the lists 
    do not match 
*****************************************************************************)
exception Mismatch
(*****************************************************************************
    (zip (xs, ys)) Given a tuple of lists (xs, ys), where xs and ys have the
    same length, returns a list of tuples with the corresponding values in xs 
    and ys put together in a tuple 
        a' list * b' list -> '(a * 'b) list
*****************************************************************************)
fun zip ([]       , []       ) = [] 
  | zip (_        , []       ) = raise Mismatch 
  | zip ([]       , _        ) = raise Mismatch 
  | zip ((x :: xs), (y :: ys)) = (x, y) :: zip (xs, ys)

(* Some new string builders *)
val int_pair_toString = Unit.pairString Unit.intString Unit.intString
val list_pair_toString = Unit.listString int_pair_toString
(* Unit Test *)
val () =
    Unit.checkExpectWith list_pair_toString "zip on integer lists"
    (fn () => zip ([1, ~2, 4], [9, 12, 0]))
    [(1, 9), (~2, 12), (4, 0)]
val () =
    Unit.checkExpectWith list_pair_toString "zip on empty"
    (fn () => zip ([], []))
    []
val () = 
    Unit.checkExnWith list_pair_toString "left smaller" 
    (fn () => zip ([1, 2], [1]))
val () = 
    Unit.checkExnWith list_pair_toString "right smaller" 
    (fn () => zip ([1, 2], [1, 2, 3, 4]))

(*** Problem 4 ***)

(*****************************************************************************
    (pairfoldrEq f acc (xs, ys)) Given a function which takes two values and 
    an accumulator and returns the new accumulator f, the initial accumulator 
    value acc, and a tuple of equal-sized lists (xs, ys), the function 
    returns the f applied to every value of (xs, ys) accumulating 
    from right to left 
        ('a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
*****************************************************************************)
fun pairfoldrEq f acc ([]       , []       ) = acc
  | pairfoldrEq f acc ([]       , _        ) = raise Mismatch
  | pairfoldrEq f acc (_        , []       ) = raise Mismatch 
  | pairfoldrEq f acc ((x :: xs), (y :: ys)) = 
        f (x, y, pairfoldrEq f acc (xs, ys)) 

(* Unit Test *)
val int_pair_toString = Unit.pairString Unit.intString Unit.intString
val bool_pair_toString = Unit.pairString Unit.boolString Unit.boolString
val list_pair_toString = Unit.listString int_pair_toString
val list_boolpair_toString = Unit.listString bool_pair_toString

fun multAndAdd (x, y, acc) = x * y + acc
fun orderMatters (x, y, acc) = x * y - acc
val () = 
    Unit.checkExpectWith Unit.intString "empty list" 
    (fn () => pairfoldrEq multAndAdd 10 ([], []))
    10
val () = 
    Unit.checkExpectWith Unit.intString "list values of generic values" 
    (fn () => pairfoldrEq multAndAdd 0 ([1, 2, 3], [2, 3, 4]))
    20
val () = 
    Unit.checkExnWith Unit.intString "uneven left array size" 
    (fn () => pairfoldrEq multAndAdd 0 ([1, 2], [2, 3, 4]))
val () = 
    Unit.checkExnWith Unit.intString "uneven right array size" 
    (fn () => pairfoldrEq multAndAdd 0 ([1, 2], [4]))
val () = 
    Unit.checkExpectWith Unit.intString "fold ordering matters" 
    (fn () => pairfoldrEq orderMatters 0 ([1, 2, 3, 4], [1, 2, 3, 4]))
    ~10

(*****************************************************************************
    (ziptoo (xs, ys)) Given a tuple of lists (xs, ys), where xs and ys have the
    same length, returns a list of tuples with the corresponding values in xs 
    and ys put together in a tuple, using pairfoldrEq
        'a list * 'b list -> ('a * 'b) list
*****************************************************************************)
fun ziptoo (xs, ys) = pairfoldrEq (fn (x, y, acc) => (x, y) :: acc) [] (xs, ys)

(* Unit Test *)
val () =
    Unit.checkExpectWith list_pair_toString "zip on integer lists"
    (fn () => ziptoo ([1, ~2, 4], [9, 12, 0]))
    [(1, 9), (~2, 12), (4, 0)]
val () =
    Unit.checkExpectWith list_pair_toString "zip on empty"
    (fn () => ziptoo ([], []))
    []
val () = 
    Unit.checkExnWith list_pair_toString "left smaller" 
    (fn () => ziptoo ([1, 2], [1]))
val () = 
    Unit.checkExnWith list_pair_toString "right smaller" 
    (fn () => ziptoo ([1, 2], [1, 2, 3, 4]))


(*** Problem 5 ***)

(*****************************************************************************
    (concat xs) Given a list of lists, returns a list of all of the lists 
    concatenated together into one list
        'a list list -> 'a list
*****************************************************************************)
fun concat []         = [] 
  | concat (ls :: xs) = ls @ concat xs

(* Unit Test *)
val () = 
    Unit.checkExpectWith int_list_toString "initially empty" 
    (fn () => concat []) 
    [] 
val () = 
    Unit.checkExpectWith int_list_toString "filled with empty" 
    (fn () => concat [[], [], [], [], [], [], [], [], [], []])
    [] 
val () = 
    Unit.checkExpectWith int_list_toString "Multiple lists"
    (fn () => concat [[1], [2, 3], [4, 5, 6], [7, 8, 9, 10]])
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
val () = 
    Unit.checkExpectWith int_list_toString "Lists with some empty" 
    (fn () => concat [[], [1], [], [], [2, 3], [4, 5, 6], [], []])
    [1, 2, 3, 4, 5, 6]

(*** Problem 6 ***)
datatype ordsx 
  = BOOL of bool
  | NUM  of int
  | SYM  of string
  | SXS  of ordsx list
fun sxString (SYM s)   = s
  | sxString (NUM n)   = Unit.intString n
  | sxString (BOOL b)  = if b then "true" else "false"
  | sxString (SXS sxs) = "(" ^ String.concatWith " " (map sxString sxs) ^ ")"

(*****************************************************************************
    (numbersSx ls) Given a list of integers ls, returns the ordinary expression
    representation of the integer list
        int list -> ordsx
*****************************************************************************)
fun numbersSx [] = SXS [] 
  | numbersSx ls = SXS (foldr (fn (n, acc) => NUM n :: acc) [] ls)

(* Unit Test *)
val () = 
    Unit.checkExpectWith sxString "empty list" 
    (fn () => numbersSx []) 
    (SXS [])
val () = 
    Unit.checkExpectWith sxString "single element" 
    (fn () => numbersSx [1]) 
    (SXS [NUM 1])
val () = 
    Unit.checkExpectWith sxString "multiple elements" 
    (fn () => numbersSx [1, 2, 3, 4, 5]) 
    (SXS [NUM 1, NUM 2, NUM 3, NUM 4, NUM 5])

(*****************************************************************************
    (flattenSyms exp) Given an ordinary expression exp, returns a list of 
    the symbols from the expression 
        ordsx -> string list
*****************************************************************************)
fun flattenSyms (SYM x)         = [x]
  | flattenSyms (SXS (x :: xs)) = flattenSyms x @ flattenSyms (SXS xs)
  | flattenSyms _               = [] 

(* Unit Test *)
val string_list_toString = Unit.listString Unit.stringString
val () = 
    Unit.checkExpectWith string_list_toString "Single symbol"
    (fn () => flattenSyms (SYM "a"))
    ["a"]
val () = 
    Unit.checkExpectWith string_list_toString "Empty List" 
    (fn () => flattenSyms (SXS []))
    [] 
val () = 
    Unit.checkExpectWith string_list_toString "Single Number" 
    (fn () => flattenSyms (NUM 1))
    [] 
val () = 
    Unit.checkExpectWith string_list_toString "Single Boolean" 
    (fn () => flattenSyms (BOOL true))
    [] 
val () =
    Unit.checkExpectWith string_list_toString "List of multiple symbols"
    (fn () => flattenSyms (SXS [SYM "A", SYM "B", SYM "C"]))
    ["A", "B", "C"]
val () =
    Unit.checkExpectWith string_list_toString "List with duplicate symbols"
    (fn () => flattenSyms (SXS [SYM "A", SYM "A", SYM "B", SYM "C", SYM "B"]))
    ["A", "A", "B", "C", "B"]
val () =
    Unit.checkExpectWith string_list_toString "List of mixed symbols"
    (fn () => flattenSyms (SXS [SYM "A", NUM 1, BOOL true, SYM "B", SYM "C"]))
    ["A", "B", "C"]
val () =
    Unit.checkExpectWith string_list_toString "Nested List"
    (fn () => flattenSyms (SXS [SXS [SYM "B", NUM 1, SXS []], SYM "A"]))
    ["B", "A"]

    