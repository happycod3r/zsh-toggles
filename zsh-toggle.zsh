
# ZSH-TOGGLE v1.0.0 - Toggles the value of an existing variable in a file
#
# In the file that contains the variable(s) that you want to toggle.
# The variable that you want to toggle should ...
#    a) be on a line of its own.
#    b) be only one of the following formats: 
#        - $MY_VAR="true"             no export statement, double quotes
#        - $MY_VAR='true'             no export statement, single quotes.
#        - $MY_VAR=true               no export statement, no quotes.
#        - export $MY_VAR="true"      export statement, double quotes
#        - export $MY_VAR='false'     export statement, single quotes.
#        - export $MY_VAR=false       export statement, no quotes.
#    c) be initialized with a value such as true|false, on|off, 1|0, yes|no John|Amy etc. 
#
           ##                           ##   
            ##          ##             ##    
   ##        ##        ##     ##      ##     
             ##       ##              ##     
             ##      ##               ##     
   ##       ##      ##        ##       ##    
           ##      ##                   ##   
                                           
function zsh-toggle(){
    
    if [[ -z "$1" || -z "$2" ]]; then
        cat >&2 <<EOF
        
        Usage: 
            zsh-toggles <bool export> <bool dquotes> <str var_name> <str value> <str alt_value> <str file_path>

        exported: If the variable has an export statement or not
        dquotes: If the value is wrapped in double or single quotes
        var_name: The name of the variable
        value: The value that the variable currently has
        alt_value: The value that you want to switch back and forth to
        f_path: The absolute path to the file containing the variable.

EOF
    fi

    # The variable you are toggling should be initialized in its 
    # file already with either VALUE or ALT_VALUE otherwise it won't work.
    # For example if you set ...
    # VALUE="yes"
    # ALT_VALUE="no" 
    # ... then in the file @ FILE_PATH the variable should be initialized 
    # with either "yes" or "no". ex. MY_VAR="yes" or MY_VAR="no"
    # The same with the other options too. If you set DQUOTES to true then the 
    # variable value should be wrapped in double quotes already in the file.
    # Your basically describing the variable with these options
    EXPORT="${1:-false}"
    DQUOTES="${2:-true}"
    VAR_NAME="$3"
    VALUE="$4"
    ALT_VALUE="$5"
    FILE_PATH="${6}"

    if [[ "$EXPORT" =~ true ]]; then

        #////////////////// EXPORTED VARIABLES ex. export MY_VAR="true" //////////////

        if [[ "$DQUOTES" =~ true ]]; then

            function _toggle_${VAR_NAME}_() {
                echo "function $0(){}"
                local file="${FILE_PATH}"
                local temp_file="${FILE_PATH}.tmp"

                # Read the file and update the SUDO variable
                while IFS= read -r line; do
                    if [[ $line =~ ^export\ ${VAR_NAME}= ]]; then
                        if [[ $line =~ export\ ${VAR_NAME}=\"${VALUE}\" ]]; then
                            line=${line/export\ ${VAR_NAME}=\"${VALUE}\"/export\ ${VAR_NAME}=\"${ALT_VALUE}\"}
                        elif [[ $line =~ export\ ${VAR_NAME}=\"${ALT_VALUE}\" ]]; then
                            line=${line/export\ ${VAR_NAME}=\"${ALT_VALUE}\"/export\ ${VAR_NAME}=\"${VALUE}\"}
                        fi
                    fi
                    echo "$line"
                done < "$file" > "$temp_file"

                # Replace the original file with the updated contents
                mv "$temp_file" "$file"
            }

            _toggle_${VAR_NAME}_
        
        #////////////////// EXPORTED VARIABLES ex. export MY_VAR='true' //////////////

        elif [[ "$DQUOTES" =~ false ]]; then

            function _toggle_${VAR_NAME}_() {
                echo "function $0(){}"
                local file="${FILE_PATH}"
                local temp_file="${FILE_PATH}.tmp"

                # Read the file and update the SUDO variable
                while IFS= read -r line; do
                    if [[ $line =~ ^export\ ${VAR_NAME}= ]]; then
                        if [[ $line =~ export\ ${VAR_NAME}=\'${VALUE}\' ]]; then
                            line=${line/export\ ${VAR_NAME}=\'${VALUE}\'/export\ ${VAR_NAME}=\'${ALT_VALUE}\'}
                        elif [[ $line =~ export\ ${VAR_NAME}=\'${ALT_VALUE}\' ]]; then
                            line=${line/export\ ${VAR_NAME}=\'${ALT_VALUE}\'/export\ ${VAR_NAME}=\'${VALUE}\'}
                        fi
                    fi
                    echo "$line"
                done < "$file" > "$temp_file"

                # Replace the original file with the updated contents
                mv "$temp_file" "$file"
            }

            _toggle_${VAR_NAME}_

        #////////////////// VARIABLE ex. export MY_VAR=true //////////////

        elif [[ "$DQUOTES" == "none" ]]; then

            function _toggle_${VAR_NAME}_() {
                echo "function $0(){}"
                local file="${FILE_PATH}"
                local temp_file="${FILE_PATH}.tmp"

                # Read the file and update the SUDO variable
                while IFS= read -r line; do
                    if [[ $line =~ ^export\ ${VAR_NAME}= ]]; then
                        if [[ $line =~ export\ ${VAR_NAME}=${VALUE} ]]; then
                            line=${line/export\ ${VAR_NAME}=${VALUE}/export\ ${VAR_NAME}=${ALT_VALUE}}
                        elif [[ $line =~ export\ ${VAR_NAME}=${ALT_VALUE} ]]; then
                            line=${line/export\ ${VAR_NAME}=${ALT_VALUE}/export\ ${VAR_NAME}=${VALUE}}
                        fi
                    fi
                    echo "$line"
                done < "$file" > "$temp_file"

                # Replace the original file with the updated contents
                mv "$temp_file" "$file"
            }

            toggle_${VAR_NAME}_

        fi

    elif [[ "$EXPORT" =~ false ]]; then

        #////////////////// VARIABLE ex. (MY_VAR="true") /////////////////////

        if [[ "$DQUOTES" =~ true ]]; then
        
            function toggle_${VAR_NAME}_() {
                echo "function $0(){}"
                local file="${FILE_PATH}"
                local temp_file="${FILE_PATH}.tmp"

                # Read the file and update the SUDO variable
                while IFS= read -r line; do
                    if [[ $line =~ ^${VAR_NAME}= ]]; then
                        if [[ $line =~ ${VAR_NAME}=\"${VALUE}\" ]]; then
                            line=${line/${VAR_NAME}=\"${VALUE}\"/${VAR_NAME}=\"${ALT_VALUE}\"}
                        elif [[ $line =~ ${VAR_NAME}=\"${ALT_VALUE}\" ]]; then
                            line=${line/${VAR_NAME}=\"${ALT_VALUE}\"/${VAR_NAME}=\"${VALUE}\"}
                        fi
                    fi
                    echo "$line"
                done < "$file" > "$temp_file"

                # Replace the original file with the updated contents
                mv "$temp_file" "$file"
            }

            toggle_${VAR_NAME}_

        #////////////////// VARIABLE ex. MY_VAR='true' //////////////

        elif [[ "$DQUOTES" =~ false ]]; then

            function toggle_${VAR_NAME}_() {
                echo "function $0(){}"
                local file="${FILE_PATH}"
                local temp_file="${FILE_PATH}.tmp"

                # Read the file and update the SUDO variable
                while IFS= read -r line; do
                    if [[ $line =~ ^${VAR_NAME}= ]]; then
                        if [[ $line =~ ${VAR_NAME}=\'${VALUE}\' ]]; then
                            line=${line/${VAR_NAME}=\'${VALUE}\'/${VAR_NAME}=\'${ALT_VALUE}\'}
                        elif [[ $line =~ ${VAR_NAME}=\'${ALT_VALUE}\' ]]; then
                            line=${line/${VAR_NAME}=\'${ALT_VALUE}\'/${VAR_NAME}=\'${VALUE}\'}
                        fi
                    fi
                    echo "$line"
                done < "$file" > "$temp_file"

                # Replace the original file with the updated contents
                mv "$temp_file" "$file"
            }

            toggle_${VAR_NAME}_

        #////////////////// VARIABLE ex. MY_VAR=true //////////////

        elif [[ "$DQUOTES" == "none" ]]; then

            function toggle_${VAR_NAME}_() {
                echo "function $0(){}"
                local file="${FILE_PATH}"
                local temp_file="${FILE_PATH}.tmp"

                # Read the file and update the SUDO variable
                while IFS= read -r line; do
                    if [[ $line =~ ^${VAR_NAME}= ]]; then
                        if [[ $line =~ ${VAR_NAME}=${VALUE} ]]; then
                            line=${line/${VAR_NAME}=${VALUE}/${VAR_NAME}=${ALT_VALUE}}
                        elif [[ $line =~ ${VAR_NAME}=${ALT_VALUE} ]]; then
                            line=${line/${VAR_NAME}=${ALT_VALUE}/${VAR_NAME}=${VALUE}}
                        fi
                    fi
                    echo "$line"
                done < "$file" > "$temp_file"

                # Replace the original file with the updated contents
                mv "$temp_file" "$file"
            }

            toggle_${VAR_NAME}_

        fi

    fi

}
