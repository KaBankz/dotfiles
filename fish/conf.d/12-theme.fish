# name: Catppuccin Mocha
# url: https://github.com/catppuccin/fish
# preferred_background: 1e1e2e

# set fish_color_normal cdd6f4
# set fish_color_command 89b4fa
# set fish_color_param f2cdcd
# set fish_color_keyword f38ba8
# set fish_color_quote a6e3a1
# set fish_color_redirection f5c2e7
# set fish_color_end fab387
# set fish_color_comment 7f849c
# set fish_color_error f38ba8
# set fish_color_gray 6c7086
# set fish_color_selection --background=313244
# set fish_color_search_match --background=313244
# set fish_color_option a6e3a1
# set fish_color_operator f5c2e7
# set fish_color_escape eba0ac
# set fish_color_autosuggestion 6c7086
# set fish_color_cancel f38ba8
# set fish_color_cwd f9e2af
# set fish_color_user 94e2d5
# set fish_color_host 89b4fa
# set fish_color_host_remote a6e3a1
# set fish_color_status f38ba8
# set fish_pager_color_progress 6c7086
# set fish_pager_color_prefix f5c2e7
# set fish_pager_color_completion cdd6f4

# name: TokyoNight
# url: https://github.com/folke/tokyonight.nvim/blob/main/extras/fish/tokyonight_night.fish

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_option $pink
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
