open! Core
open! Async

module Operator : sig
  type t

  val of_string : string -> t option
end

module Imaginary : sig
  type t
end

module Literal : sig
  type t
end

module Keyword : sig
type t =
    | Break
    | Default
    | Func
    | Interface
    | Select
    | Case
    | Defer
    | Go
    | Map
    | Struct
    | Chan
    | Else
    | Goto
    | Package
    | Switch
    | Const
    | Fallthrough
    | If
    | Range
    | Type
    | Continue
    | For
    | Import
    | Return
    | Var
end

module Token : sig
  type t =
  | Identifier of string
  | Literal of Literal.t
  | Keyword of Keyword.t
end
