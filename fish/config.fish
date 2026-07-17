if status is-interactive
    set -gx FNM_DIR $HOME/.local/share/fnm
    set -gx PATH $FNM_DIR $PATH
    fnm env | source
end
