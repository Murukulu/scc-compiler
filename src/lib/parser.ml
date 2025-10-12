open! Async
open! Tokens
open Ast

(* https://go.dev/ref/spec#Expressions *)

module PackageName = struct
end

let parse _tokens =
  ()

let parse_package_clause (tokens : Token.t list) =
    match tokens with
    | Token.Keyword Keyword.Package :: Token.Identifier name :: tokens
      -> Some (Ast.PackageClause { name = PackageName name}, tokens)
    | _ -> None
   
