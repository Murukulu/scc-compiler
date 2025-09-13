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
  type t
end

module Token : sig
  type t
end
