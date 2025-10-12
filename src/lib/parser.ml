open! Async
open! Tokens
open Ast

(* https://go.dev/ref/spec#Expressions *)

module PackageName = struct
end

let parse _tokens =
  ()

let _parse_package_clause (tokens : Token.t list) : (Ast.package_clause * Token.t list) option =
    match tokens with
    | Token.Keyword Keyword.Package :: Token.Identifier name :: rest
      -> Some (PackageClause { name = PackageName name}, rest)
    | _ -> None

(* https://go.dev/ref/spec#Import_declarations *)
let _parse_import_path (tokens : Token.t list) : (Ast.import_path * Token.t list) option =
  let open Token in
  match tokens with
  | Literal Literal.String path :: rest
    -> Some (ImportPath path, rest)
  | _ -> None

let _parse_import_spec (tokens : Token.t list) : (Ast.import_spec * Token.t list) option =
  let open Token in
  match tokens with
  | Literal (Literal.String ".") :: Literal (Literal.String path) :: rest ->
      Some (ImportSpec (PackageName ".", ImportPath path), rest)
  | Literal (Literal.String package_name) :: Literal (Literal.String path) :: rest ->
      Some (ImportSpec (PackageName package_name, ImportPath path), rest)
  | _ -> None

let _parse_import_decl (tokens : Token.t list) : (Ast.import_decl * Token.t list) option =
  let open Token in
  match tokens with
  | (Keyword Keyword.Import) :: (Operator Operator.OpenBracket) :: rest ->
    let rec aux imports toks =
      match _parse_import_spec toks with
      | Some (spec, Operator Operator.SemiColon :: rest') -> aux (spec :: imports) rest'
      | Some (spec, Operator Operator.CloseBracket :: rest') ->
        Some (List.rev (spec :: imports ), rest')
      | _ -> None
    in
    begin
    match aux [] rest with
      | Some (specs, rest') -> Some (MultiImport specs, rest')
      | None -> None
    end
  | (Keyword Keyword.Import) :: rest ->
    begin
    match _parse_import_spec rest with
      | Some (spec, rest') -> Some (SingleImport spec, rest')
      | _ -> None
    end
  | _ -> None
