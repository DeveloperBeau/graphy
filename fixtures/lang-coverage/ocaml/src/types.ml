(* feature: type alias, record, variant, module signature *)

type id = int
type name = string

type state = Idle | Running | Done

type service = {
  id : id;
  name : name;
}

module type Greet = sig
  val greeting : string -> string
end
