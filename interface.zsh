

if [[ -f "$(pwd)/zsh-toggles.zsh" ]]; then 
    builtin source $(pwd)/zsh-toggles.zsh
fi


    # Usage: 
    #     zsh-toggles <bool export> <bool dquotes> <str var_name> <str value> <str alt_value> <str file_path>
    #
    # exported: If the variable has an export statement or not
    # dquotes: If the value is wrapped in double or single quotes
    # var_name: The name of the variable
    # value: The value that the variable currently has
    # alt_value: The value that you want to switch back and forth to
    # f_path: The absolute path to the file containing the variable.

zsh-toggles false "none" TEST "false" "true" "$(pwd)/test.conf"
