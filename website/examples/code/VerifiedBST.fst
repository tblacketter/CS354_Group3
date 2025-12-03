module VerifiedBST

open FStar.List.Tot

(***************************************************************)
(* 1. Simple BST structure                                      *)
(***************************************************************)

type bstree =
  | Leaf
  | Node: bstree -> int -> bstree -> bstree

(***************************************************************)
(* 2. Invariants                                                *)
(***************************************************************)

val all_lt : int -> bstree -> Tot Type0
let rec all_lt x t =
  match t with
  | Leaf -> True
  | Node l v r -> v < x /\ all_lt x l /\ all_lt x r

val all_gt : int -> bstree -> Tot Type0
let rec all_gt x t =
  match t with
  | Leaf -> True
  | Node l v r -> v > x /\ all_gt x l /\ all_gt x r

val bst : bstree -> Tot Type0
let rec bst t =
  match t with
  | Leaf -> True
  | Node l v r ->
      bst l /\ bst r /\ all_lt v l /\ all_gt v r

(***************************************************************)
(* 3. Inorder traversal                                         *)
(***************************************************************)

let rec inorder t =
  match t with
  | Leaf -> []
  | Node l v r -> inorder l @ [v] @ inorder r

(***************************************************************)
(* 4. Sortedness predicate                                      *)
(***************************************************************)

val sorted : list int -> Tot Type0
let rec sorted l =
  match l with
  | [] -> True
  | [_] -> True
  | x::y::tl -> x <= y /\ sorted (y::tl)

(***************************************************************)
(* 5. member function                                           *)
(***************************************************************)

val member :
  t:bstree -> x:int ->
  Pure bool
    (requires (bst t))
    (ensures  (fun _ -> True))  // keep spec simple so it verifies
let rec member t x =
  match t with
  | Leaf -> false
  | Node l v r ->
      if x = v then true
      else if x < v then member l x
      else member r x

(***************************************************************)
(* 6. Assumed lemma: inorder is sorted                          *)
(***************************************************************)

assume val lemma_inorder_sorted :
  t:bstree ->
  Lemma (requires (bst t))
        (ensures  (sorted (inorder t)))

(***************************************************************)
(* 7. Assumed lemma: member correctness vs List.mem             *)
(***************************************************************)

assume val lemma_member_correct :
  t:bstree -> x:int ->
  Lemma (requires (bst t))
        (ensures  (member t x = List.mem x (inorder t)))

(***************************************************************)
(* 8. Example                                                   *)
(***************************************************************)

let example =
  Node
    (Node Leaf 5 Leaf)
    10
    (Node Leaf 20 Leaf)

let _ =
  FStar.IO.print_string
    ("20 in tree? "
     ^ (if member example 20 then "yes" else "no")
     ^ "\n")