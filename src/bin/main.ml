open! Core
open Cmdliner

let verbose_flag =
  Arg.(value & flag & info ["v"; "verbose"] ~doc:"Print verbose output.")

let src_file =
  let doc = "The path to the input file." in
  let info' = Arg.info ~docv:"FILE_PATH" ~doc ["f"; "file"] in
  Arg.(required (opt (some file) None info'))

let main src_file verbose =
  Scc.Lexer.lex src_file verbose

let cmd_info =
  Cmd.info "SCC Compiler" ~version:"1.0.0" ~doc:"The Sai-Cyrus-Cassar Compiler, developed from scratch."

let main_cmd =
  Cmd.v cmd_info Term.(const main $ src_file $ verbose_flag)

let () =
  exit (Cmd.eval main_cmd)
