module Ast : sig
  type package_name = PackageName of string
  type package_clause = PackageClause of { name : package_name; }

  type import_path = ImportPath of string
  type import_spec = ImportSpec of package_name * import_path
  type import_decl =
    | SingleImport of import_spec
    | MultiImport of import_spec list
end
