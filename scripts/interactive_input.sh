#!/bin/sh

function interactive_input
{
    echo  "Please type y/Y to continue,or n/N to exit"
    while [ 1 ]
    do
            read input
            case $input in
            y|Y)
                    break
                    ;;
            n|N)
                    exit
                    ;;
            *)
                    echo "Unrecognized command $input.Please y/Y or n/N"
                    continue
                    ;;
            esac
    done
    unset input
}

interactive_input