module Commutative

let add (x:int) (y:int) : int =
  x + y

val add_comm :
  x:int ->
  y:int ->
  Lemma (
    ensures add x y == add y x
  )

let add_comm x y =
  ()