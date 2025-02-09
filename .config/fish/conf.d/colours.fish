function update_theme --on-variable os_theme --description "Apply theme"
    if test $os_theme = dark
        base16-gruvbox-dark-medium
    else
        base16-gruvbox-light-medium
    end
end

function base16-gruvbox-dark-medium -d "base16 Gruvbox dark, medium theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "28/28/28" # Base 00 - Black
    set color01 "fb/49/34" # Base 08 - Red
    set color02 "b8/bb/26" # Base 0B - Green
    set color03 "fa/bd/2f" # Base 0A - Yellow
    set color04 "83/a5/98" # Base 0D - Blue
    set color05 "d3/86/9b" # Base 0E - Magenta
    set color06 "8e/c0/7c" # Base 0C - Cyan
    set color07 "d5/c4/a1" # Base 05 - White
    set color08 "66/5c/54" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "fb/f1/c7" # Base 07 - Bright White
    set color16 "fe/80/19" # Base 09
    set color17 "d6/5d/0e" # Base 0F
    set color18 "3c/38/36" # Base 01
    set color19 "50/49/45" # Base 02
    set color20 "bd/ae/93" # Base 04
    set color21 "eb/db/b2" # Base 06
    set color_foreground "d5/c4/a1" # Base 05
    set color_background "28/28/28" # Base 00

    # 16 color space
    __put_template 0  $color00
    __put_template 1  $color01
    __put_template 2  $color02
    __put_template 3  $color03
    __put_template 4  $color04
    __put_template 5  $color05
    __put_template 6  $color06
    __put_template 7  $color07
    __put_template 8  $color08
    __put_template 9  $color09
    __put_template 10 $color10
    __put_template 11 $color11
    __put_template 12 $color12
    __put_template 13 $color13
    __put_template 14 $color14
    __put_template 15 $color15

    # 256 color space
    __put_template 16 $color16
    __put_template 17 $color17
    __put_template 18 $color18
    __put_template 19 $color19
    __put_template 20 $color20
    __put_template 21 $color21

    # foreground / background / cursor color
    if test -n "$ITERM_SESSION_ID"
        # iTerm2 proprietary escape codes
        __put_template_custom Pg d5c4a1 # foreground
        __put_template_custom Ph 282828 # background
        __put_template_custom Pi d5c4a1 # bold color
        __put_template_custom Pj 504945 # selection color
        __put_template_custom Pk d5c4a1 # selected text color
        __put_template_custom Pl d5c4a1 # cursor
        __put_template_custom Pm 282828 # cursor text

    else
        __put_template_var 10 $color_foreground
        if test "$BASE16_SHELL_SET_BACKGROUND" != false
            __put_template_var 11 $color_background
            if string match -q -- '*rxvt*' $TERM
                __put_template_var 708 $color_background # internal border (rxvt)
            end
        end
        __put_template_custom 12 ";7" # cursor (reverse video)
    end

    if test -z $base16_fish_shell_disable_prompt_colors
        set -gx fish_color_normal normal
        set -gx fish_color_command "83a598" blue
        set -gx fish_color_quote "b8bb26" green
        set -gx fish_color_redirection "fabd2f" yellow
        set -gx fish_color_end "8ec07c" cyan
        set -gx fish_color_error "fb4934" red
        set -gx fish_color_param "ebdbb2" cyan
        set -gx fish_color_comment "665c54" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "d5c4a1" white --bold --background=brblack
        set -gx fish_color_search_match "fabd2f" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "8ec07c" cyan
        set -gx fish_color_escape "8ec07c" cyan
        set -gx fish_color_cwd "b8bb26" green
        set -gx fish_color_cwd_root "fb4934" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "665c54" brblack
        set -gx fish_color_user "b8bb26" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "fabd2f" yellow
        set -gx fish_pager_color_prefix "d5c4a1" white --bold --underline
        set -gx fish_pager_color_progress "fbf1c7" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "28" "28" "28"
    __base16_fish_shell_create_vimrc_background gruvbox-dark-medium
    set -U base16_fish_theme gruvbox-dark-medium

    if test -n "$_flag_t"
        set base16_colors_hex
        set padded_seq_values (seq -w 0 21)
        for seq_value in $padded_seq_values
            set -l color "color$seq_value"
            set base16_colors_hex $base16_colors_hex (string replace -a / "" $$color)
        end

        __base16_fish_shell_color_test $base16_colors_hex
    end
end

function base16-gruvbox-light-medium -d "base16 Gruvbox light, medium theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "fb/f1/c7" # Base 00 - Black
    set color01 "9d/00/06" # Base 08 - Red
    set color02 "79/74/0e" # Base 0B - Green
    set color03 "b5/76/14" # Base 0A - Yellow
    set color04 "07/66/78" # Base 0D - Blue
    set color05 "8f/3f/71" # Base 0E - Magenta
    set color06 "42/7b/58" # Base 0C - Cyan
    set color07 "50/49/45" # Base 05 - White
    set color08 "bd/ae/93" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "28/28/28" # Base 07 - Bright White
    set color16 "af/3a/03" # Base 09
    set color17 "d6/5d/0e" # Base 0F
    set color18 "eb/db/b2" # Base 01
    set color19 "d5/c4/a1" # Base 02
    set color20 "66/5c/54" # Base 04
    set color21 "3c/38/36" # Base 06
    set color_foreground "50/49/45" # Base 05
    set color_background "fb/f1/c7" # Base 00

    # 16 color space
    __put_template 0  $color00
    __put_template 1  $color01
    __put_template 2  $color02
    __put_template 3  $color03
    __put_template 4  $color04
    __put_template 5  $color05
    __put_template 6  $color06
    __put_template 7  $color07
    __put_template 8  $color08
    __put_template 9  $color09
    __put_template 10 $color10
    __put_template 11 $color11
    __put_template 12 $color12
    __put_template 13 $color13
    __put_template 14 $color14
    __put_template 15 $color15

    # 256 color space
    __put_template 16 $color16
    __put_template 17 $color17
    __put_template 18 $color18
    __put_template 19 $color19
    __put_template 20 $color20
    __put_template 21 $color21

    # foreground / background / cursor color
    if test -n "$ITERM_SESSION_ID"
        # iTerm2 proprietary escape codes
        __put_template_custom Pg 504945 # foreground
        __put_template_custom Ph fbf1c7 # background
        __put_template_custom Pi 504945 # bold color
        __put_template_custom Pj d5c4a1 # selection color
        __put_template_custom Pk 504945 # selected text color
        __put_template_custom Pl 504945 # cursor
        __put_template_custom Pm fbf1c7 # cursor text

    else
        __put_template_var 10 $color_foreground
        if test "$BASE16_SHELL_SET_BACKGROUND" != false
            __put_template_var 11 $color_background
            if string match -q -- '*rxvt*' $TERM
                __put_template_var 708 $color_background # internal border (rxvt)
            end
        end
        __put_template_custom 12 ";7" # cursor (reverse video)
    end

    if test -z $base16_fish_shell_disable_prompt_colors
        set -gx fish_color_normal normal
        set -gx fish_color_command "076678" blue
        set -gx fish_color_quote "79740e" green
        set -gx fish_color_redirection "b57614" yellow
        set -gx fish_color_end "427b58" cyan
        set -gx fish_color_error "9d0006" red
        set -gx fish_color_param "3c3836" cyan
        set -gx fish_color_comment "bdae93" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "504945" white --bold --background=brblack
        set -gx fish_color_search_match "b57614" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "427b58" cyan
        set -gx fish_color_escape "427b58" cyan
        set -gx fish_color_cwd "79740e" green
        set -gx fish_color_cwd_root "9d0006" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "bdae93" brblack
        set -gx fish_color_user "79740e" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "b57614" yellow
        set -gx fish_pager_color_prefix "504945" white --bold --underline
        set -gx fish_pager_color_progress "282828" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "fb" "f1" "c7"
    __base16_fish_shell_create_vimrc_background gruvbox-light-medium
    set -U base16_fish_theme gruvbox-light-medium

    if test -n "$_flag_t"
        set base16_colors_hex
        set padded_seq_values (seq -w 0 21)
        for seq_value in $padded_seq_values
            set -l color "color$seq_value"
            set base16_colors_hex $base16_colors_hex (string replace -a / "" $$color)
        end

        __base16_fish_shell_color_test $base16_colors_hex
    end
end
