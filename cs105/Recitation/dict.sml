functor DictFn (structure Key : KEY) :> DICT where type key = Key.key = 
struct 
    type key      = Key.key     (* a key used for lookup *)
    type 'a dict  = (key * 'a) list 
        (* a finite map from keys to values of type 'a *)

    exception NotFound of key
    
    val empty = []
    
    fun find (key, []) = raise NotFound key 
      | find (key, (x, v) :: xs) = 
        (case Key.compare (key, x)
           of EQUAL => v 
            | _     => find (key, xs))

    fun bind (key, v, []) = [(key, v)]
      | bind (key, v, (x, v2) :: xs) = 
            (case Key.compare (key, x) 
               of EQUAL => (key, v) :: xs 
                | _     => (x, v2)  :: bind (key, v, xs))

    (* contracts:
        empty  is the empty map
        find (k, d) returns the x that d maps k to, or if d does not map k,
                    it raises `NotFound k`
        bind (k, x, d) = d' such that
                                - d' maps k to x
                                - if k' <> k, d' maps k' the same way d does
        laws:
        find (k, bind (k,  x, d)) = x
        find (k, bind (k', x, d)) = find (k, d)  if k <> k'
        find (k, empty)   raises NotFound k
    *)
end 

