let () = print_endline "Hello, World!"

let is_keyword _ = false

let is_alpha c =
  let code = Char.code c in
  code >= Char.code 'a' && code <= Char.code 'z'

let ident =
  let open Opal in
  many1 (satisfy is_alpha) >>= fun id ->
  if is_keyword id then mzero else return id

let ident2 : char Opal.LazyStream.t -> char list option =
  let open Opal.LazyStream in
  let rec loop dxs finish = function
    | Cons (c, (lazy cs)) when is_alpha c ->
        loop (fun xs -> dxs @@ c :: xs) finish cs
    | cs -> finish (dxs []) cs
  in
  function
  | Opal.LazyStream.Cons (c, (lazy cs)) when is_alpha c ->
      loop
        (fun x -> x)
        (fun xs _ -> if is_keyword (c :: xs) then None else Some (c :: xs))
        cs
  | _ -> None

let () =
  let f p = p (Opal.LazyStream.of_string "asdfqwer") |> ignore in
  Benchmark.throughputN 1
    [ ("pc", f, fun s -> Opal.parse ident s); ("unrolled", f, ident2) ]
  |> Benchmark.tabulate
