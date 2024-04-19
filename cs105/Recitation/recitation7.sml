
(* datatype ty = ...
            | RECTY of (name * ty) list 

datatype exp = ...
             | RECMAKE of (name * exp) list 
             | RECDOT  of exp * name

(* fun typeof (e, ksee, phi, rho) = 
    let fun tf (...) = ... 
        fun tf (RECMAKE names) = 
            let List.map 
                (fn (x) => ) *)
   *)

(* 
    RECMAKE is introduction
    RECDOT  is elimination
 *)

(*



 *)

fun typeof (AND (e1, e2), Gamma) = 
        (case (typeof e1, typeof e2) 
           of (BOOLTY, BOOLTY) => BOOLTY 
            | _                => raise IllTyped)
  | typeof (BOOLTOINT e, Gamma) = 
        (case typeof (e1, Gamma)
           of BOOLTY => INTTY 
            | _      => raise IllTyped)


