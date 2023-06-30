
#//////////////////////// EXPORT VARIABLES //////////////

function _toggle_sudo_variable() {
    local file="${XCONFIG}/xeta.conf"
    local temp_file="${XCONFIG}.xeta.conf.tmp"

    # Read the file and update the SUDO variable
    while IFS= read -r line; do
        if [[ $line =~ ^export\ SUDO= ]]; then
            if [[ $line =~ export\ SUDO=\"true\" ]]; then
                line=${line/export\ SUDO=\"true\"/export\ SUDO=\"false\"}
            elif [[ $line =~ export\ SUDO=\"false\" ]]; then
                line=${line/export\ SUDO=\"false\"/export\ SUDO=\"true\"}
            fi
        fi
        echo "$line"
    done < "$file" > "$temp_file"

    # Replace the original file with the updated contents
    mv "$temp_file" "$file"
}

#//////////////////////// VARIABLES /////////////////////
 
function toggle_use_zsh_hooks_variable() {
    local file="${XCONFIG}/xeta.conf"
    local temp_file="${XCONFIG}.xeta.conf.tmp"

    # Read the file and update the SUDO variable
    while IFS= read -r line; do
        if [[ $line =~ ^USE_ZSH_HOOKS= ]]; then
            if [[ $line =~ USE_ZSH_HOOKS=\"true\" ]]; then
                line=${line/USE_ZSH_HOOKS=\"true\"/USE_ZSH_HOOKS=\"false\"}
            elif [[ $line =~ USE_ZSH_HOOKS=\"false\" ]]; then
                line=${line/USE_ZSH_HOOKS=\"false\"/USE_ZSH_HOOKS=\"true\"}
            fi
        fi
        echo "$line"
    done < "$file" > "$temp_file"

    # Replace the original file with the updated contents
    mv "$temp_file" "$file"
}