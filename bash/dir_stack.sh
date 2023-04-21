#===========================colors===========================
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
#===========================Alias============================
# write by junw
alias dv=get_dir_stack
alias pd=add_stack_item
alias pp=remove_stack_item
alias jp=jumpinto_idx_item
#=========================Function===========================

# directory stack
dirs_stack=()
staics_dirs_stack=()
static_config_file=""

# function to detect dir is in the stack or not
function is_arr_item() {
    local test_item="$1"
    shift

    local arr=("$@")

    for item in "${arr[@]}"
    do 
        if [ "$item" = "$test_item" ]; then
            echo "true"
            return
        fi
    done

    echo "false"
    return
}


# function to remove the index element in array
function remove_arr_item() {
    local index=$1
    shift
    local arr=("$@")
    arr=("${arr[@]:0:(($index-1))}" "${arr[@]:$((index))}")
    echo "${arr[@]}"
}

# function to get all the dirs in dynmatic and static stack
# * dv: list all the item in the stacks
function get_dir_stack() {
    if [ -z "${dirs_stack}" ]; then
        echo -e "${RED}The stack is empty, use 'pd dir_name' to push the directory to the stack${NOCOLOR}"
    else
        echo -e "${GREEN}Directory Stack:${NOCOLOR}"
        echo -e "${YELLOW}-------------------------------------------------------------${NOCOLOR}"

        for ((i=1; i<=${#${dirs_stack[@]}}; i++))
        do
            echo "$i    ${YELLOW}|${NOCOLOR}    ${dirs_stack[$i]}"
        done
        echo -e "${YELLOW}-------------------------------------------------------------${NOCOLOR}"
    fi
}


# functionn to pushd a directory to dymatic directory stack
# * pd: put current dir to stack
# * pd $dir_name: put dir_name to stack
function add_stack_item() {
    if [ -z "$1" ]; then
        if [ "$(is_arr_item "$(pwd)" "${dirs_stack[@]}")" = "true" ]; then
            echo -e "${RED}$(pwd) has been added in the stack${NOCOLOR}"
        else
            dirs_stack+=("$(pwd)")
            echo -e "${BLUE}$(pwd)${NOCOLOR} add in the stack"
        fi
    elif [ "$(is_arr_item "$1" "${dirs_stack[@]}")" = "true" ]; then
        echo -e "${RED}$1 has been added in the stack${NOCOLOR}"
    elif [ -d "$1" ]; then
        dirs_stack+=("$1")
        echo -e "${BLUE}$1${NOCOLOR} has been added in the stack"
    else
        echo -e "${RED}The directory your input isn't exist${NOCOLOR}"
    fi
}

# function to remove element in directory stack
# * pp $idx: remove the arrary[idx] element in stack
function remove_stack_item() {
    if [[ $1 =~ ^[0-9]+$ ]] && [ "$1" -le ${#dirs_stack[@]} ]; then
        dirs_stack=($(remove_arr_item $1 "${dirs_stack[@]}"))
    else
        echo -e "${RED}The index $1 must less than stack length ${#dirs_stack[@]}"
    fi
}

# function to jump to the directory index is $idx
# * jp $idx: remove the arrary[idx] element in stack
function jumpinto_idx_item() {
    if [[ $1 =~ ^[0-9]+$ ]] && [ "$1" -le ${#dirs_stack[@]} ]; then
        cd ${dirs_stack[$1]}
        echo -e "${RED}Jump${NOCOLOR} to ${GREEN}${PWD}${NOCOLOR}"
    else
        echo -e "${RED}The index $1 must less than stack length ${#dirs_stack[@]}"
    fi
}
