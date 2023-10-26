return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                    highlight = "Comment",
                    include = {
                        node_type = {
                            lua = {
                                'chunk',
                                'do_statement',
                                'while_statement',
                                'repeat_statement',
                                'if_statement',
                                'for_statement',
                                'function_declaration',
                                'function_definition',
                                'table_constructor',
                                'assignment_statement',
                            },
                            go = {
                                'struct_type',
                                'struct_elem',
                                'struct_field',
                                'keyed_element',
                                'const_declaration',
                                'import_declaration',
                                'type_declaration',
                                'literal_value'
                            },
                            rust = {
                                'declaration_list',
                                'let_declaration',
                                'arguments'
                            }

                        }
                    }
                },
            })
        end
    }
}
