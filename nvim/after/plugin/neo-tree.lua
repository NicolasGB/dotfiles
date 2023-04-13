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

                -- Kore
                ".env.local",
                "docker-compose.override.yaml"

            },
        }
    }
})
