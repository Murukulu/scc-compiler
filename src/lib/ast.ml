module Ast = struct
  type package_name = PackageName of string
  type package_clause = PackageClause of { name : package_name; }
end
