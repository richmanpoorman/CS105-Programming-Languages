(*****************
    Name       : Matthew Wong 
    Assignment : Programming With ML
    File       : warmup.sml
*****************)

(*** Problem 1 ***)

(*****************************************************************************
    (mynull ls) Given a list ls, returns true if ls is empty, false otherwise 
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
*****************************************************************************)
fun pairfoldrEq f acc ([], []) = acc
  | pairfoldrEq f acc ([], _) = raise Mismatch
  | pairfoldrEq f acc (_ ,[]) = raise Mismatch 
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
    ~8

(*****************************************************************************
    (ziptoo (xs, ys)) Given a tuple of lists (xs, ys), where xs and ys have the
    same length, returns a list of tuples with the corresponding values in xs 
    and ys put together in a tuple, using pairfoldrEq
*****************************************************************************)
fun ziptoo (xs, ys) = 
    pairfoldrEq (fn (x, y, acc) => (x, y) :: acc) [] (xs, ys) 

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