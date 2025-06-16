open Core

let command =
  Command.basic
    ~summary:"SCC Compiler"
    (
      (* 1. This opens the module that provides the special syntax. *)
      let open Command.Let_syntax in

      (* 2. This syntax block makes `flag` and others available. *)
      let%map_open
        (*
           CORRECT: `flag` is called inside the `let%map_open` block.
        *)
        slow = flag "-slow" no_arg ~doc:"A demonstration flag"
      in
      fun () ->
        if slow then
          print_endline "hello world (slowly!)"
        else
          print_endline "hello world"
    )
;;

let () = let _ = command in Command.run
