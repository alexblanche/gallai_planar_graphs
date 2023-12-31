(** Main program **)

(* Requires library ocamlfind *)
#use "topfind";;
#require "graphics";;

#use "constants.ml";;
#use "miscellaneous.ml";;
#use "graph_types.ml";;
#use "libraries/dijkstra.ml";;
#use "colors.ml";;
#use "reductions.ml";;
#use "configC0.ml";;
#use "configC1.ml";;
#use "configC2.ml";;
#use "libraries/union_find.ml";;
#use "path_check.ml";;
#use "components.ml";;
#use "visualizer.ml";;


(* Main function *)
let build_reduction (og : graph) =
	let g = copy_of_graph og in
	let r = empty_reduction g in
	(* First step: C0 configurations *)
	all_C0 g r;
	(* CI configurations *)
	all_C1 g r;
	(* CII configuration *)
	all_C2 g r;
	r;;

let gallai (g : graph) =
	let r = build_reduction g in
	(* temporary: to be replaced by a bruteforce on a very small graph *)
	let cg = generic_coloring r.g in
	apply_recoloring r cg;;


(* TODO :
	- Implement the safety algorithm
	- Implement the colors in the visualizer
	- Implement a bruteforce of a good coloring (to be used on a very small graph in the base case of the recursion)
	- Integrate the visualization of the graph in the reduction functions
	
	CI
	- Define type of half-rule: CV of int list | CN of int list | ...
	- Define type of CI configuration: A of int list | B1 of int list | ... | COMP of (half * half * edge list)
	- is_there_C1: returns a pair of vertices and the type of CI configuration (implemented like the tree of cases and not like is_there_C0)
	- Define a rule of each case of "close" CI configuration
	- Define a half-rule for each case of case of half-rule
	- combine_half h1 h2 s: returns a rule that combines 2 half-rules h1 and h2, associated with the path (s : edge list)

	CII
	- Implement a function that returns a K4-subdivision in an almost 4-connected planar graph (Yu? KKB?)
  - Define all patterns: CT1 of int list | ...
  - Define a rule for each of the configurations D,J,R
  - is_there_C2: returns four vertices and the type of CII configuration (implemented like the tree of cases)
  - combine_patterns pl s: returns a rule that combines a set of 2 to 4 patterns (from a list pl), associated with the subdivision (s: edge list)
*)