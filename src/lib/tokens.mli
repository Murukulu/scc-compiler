open! Core
open! Async

module Operator : sig
  type t =
    | Plus
    | Minus
    | Multiply
    | Divide
    | Modulo
    | BitwiseOr
    | BitwiseAnd
    | BitwiseXor
    | BitwiseLeftShift
    | BitwiseRightShift
    | BitwiseClear
    | Increment
    | Decrement
    | PlusAndAssign
    | MinusAndAssign
    | MultiplyAndAssign
    | DivideAndAssign
    | ModuloAndAssign
    | BitwiseOrAndAssign
    | BitwiseAndAndAssign
    | BitwiseXorAndAssign
    | BitwiseLeftShiftAndAssign
    | BitwiseRightShiftAndAssign
    | BitwiseClearAndAssign
    | BitwiseNot
    | LogicalAnd
    | LogicalOr
    | LogicalNot
    | Receive
    | Equals
    | NotEquals
    | LessThan
    | LessThanOrEqualTo
    | GreaterThan
    | GreaterThanOrEqualTo
    | Assign
    | Declaration
    | Ellipsis
    | OpenBracket
    | CloseBracket
    | OpenSquareBracket
    | CloseSquareBracket
    | OpenCurlyBracket
    | CloseCurlyBracket
    | Comma
    | Period
    | SemiColon
    | Colon
  
  val of_string : string -> t option
end

module Imaginary : sig
  type t
end

module Literal : sig
  type t =
    | Integer of int64
    | Float of float
    | Imaginary of Imaginary.t
    | Rune of Uchar.t
    | String of String.t
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
  | Operator of Operator.t
end
