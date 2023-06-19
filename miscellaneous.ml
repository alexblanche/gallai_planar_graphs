(* Miscellaneous non-graph-related functions *)

(* Counts the number of elements of l that satisfy the predicate p *)
let count p l = List.length (List.filter p l);;

(* Generates all the pairs of elements of l *)
let pairs_of l =
	let pair_x x = List.map (fun y -> (x,y)) in
	let rec aux l acc =
		match l with
			| [] -> acc
			| h::t -> aux t (List.rev_append (pair_x h t) acc)
	in
	aux l [];;