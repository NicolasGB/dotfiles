require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            always_show = {
                ".gitignore",
                ".gitlab-ci.yml",
                "target",
                "Cargo.lock",
                ".env",
                ".ssh",
                ".shared",

                -- Kore
                ".env.local",
                "docker-compose.override.yaml"

            },
        },
        follow_current_file = true,
    },
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                --auto close
                require("neo-tree").close_all()
            end
        },

    },
})
