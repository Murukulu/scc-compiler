open! Core
open! Async

module Imaginary = struct
  type t = Integer of int64 | Float of float [@@warning "-37"]
end

module Operator = struct
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
    | BitwiseAndNot
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
    | BitwiseAndNotAndAssign
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
    | OpenBracketSquare
    | CloseBracketSquare
    | OpenBracketCurly
    | CloseBracketCurly
    | Comma
    | Period
    | SemiColon
    | Colon

  let of_string str =
    match str with
    | "+" -> Some Plus
    | "-" -> Some Minus
    | "*" -> Some Multiply
    | "/" -> Some Divide
    | "%" -> Some Modulo
    | "|" -> Some BitwiseOr
    | "&" -> Some BitwiseAnd
    | "^" -> Some BitwiseXor
    | "~" -> Some BitwiseNot
    | "<<" -> Some BitwiseLeftShift
    | ">>" -> Some BitwiseRightShift
    | "&^" -> Some BitwiseAndNot
    | "++" -> Some Increment
    | "--" -> Some Decrement
    | "+=" -> Some PlusAndAssign
    | "-=" -> Some MinusAndAssign
    | "*=" -> Some MultiplyAndAssign
    | "/=" -> Some DivideAndAssign
    | "%=" -> Some ModuloAndAssign
    | "|=" -> Some BitwiseOrAndAssign
    | "&=" -> Some BitwiseAndAndAssign
    | "^=" -> Some BitwiseXorAndAssign
    | "<<=" -> Some BitwiseLeftShiftAndAssign
    | ">>=" -> Some BitwiseRightShiftAndAssign
    | "&^=" -> Some BitwiseAndNotAndAssign
    | "&&" -> Some LogicalAnd
    | "||" -> Some LogicalOr
    | "!" -> Some LogicalNot
    | "<-" -> Some Receive
    | "==" -> Some Equals
    | "!=" -> Some NotEquals
    | "<" -> Some LessThan
    | "<=" -> Some LessThanOrEqualTo
    | ">" -> Some GreaterThan
    | ">=" -> Some GreaterThanOrEqualTo
    | "=" -> Some Assign
    | ":=" -> Some Declaration
    | "..." -> Some Ellipsis
    | "(" -> Some OpenBracket
    | ")" -> Some CloseBracket
    | "[" -> Some OpenBracketSquare
    | "]" -> Some CloseBracketSquare
    | "{" -> Some OpenBracketCurly
    | "}" -> Some CloseBracketCurly
    | "," -> Some Comma
    | "." -> Some Period
    | ";" -> Some SemiColon
    | ":" -> Some Colon
    | _ -> None
end

module Literal = struct
  type t =
    | Integer of int64
    | Float of float
    | Imaginary of Imaginary.t
    | Rune of Uchar.t
    | String of String.t
  [@@warning "-37"]
end

module Keyword = struct
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
  [@@warning "-37"]
end

module Token = struct
  type t = Identifier of string | Literal of Literal.t | Keyword of Keyword.t
  [@@warning "-37"]
end
