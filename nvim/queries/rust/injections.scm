(
 (line_comment
   doc: (doc_comment) @injection.content
   )
 (#set! injection.language "markdown")
 (#set! injection.include-children)
 )

; Highlight raw JavaScript strings passed directly to Dioxus document::eval.
(call_expression
  function: (scoped_identifier
    path: (identifier) @_module
    name: (identifier) @_function)
  arguments: (arguments
    . (raw_string_literal
        (string_content) @injection.content))
  (#eq? @_module "document")
  (#eq? @_function "eval")
  (#set! injection.language "javascript"))

; Opt in raw strings with // language= or // lang=, using javascript or js.
((raw_string_literal
   (string_content) @injection.content)
  (#match? @injection.content "\\m^\\_s*//\\s*lang\\%(uage\\)\\?\\s*=\\s*\\%(javascript\\|js\\)\\>")
  (#set! injection.language "javascript"))
