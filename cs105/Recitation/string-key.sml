structure StringKey :> KEY where type key = string = 
struct 
    type key    = string 
    val compare = String.compare 
end 