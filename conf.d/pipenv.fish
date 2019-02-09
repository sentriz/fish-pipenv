# set the user installation path

if command -s pipenv > /dev/null
    
    # complete --command pipenv --arguments "(env _PIPENV_COMPLETE=complete-fish COMMANDLINE=(commandline -cp) pipenv)" -f
    
    function __pipenv_shell_activate --on-variable PWD
        if status --is-command-substitution
            return
        end
        if not test -e "$PWD/Pipfile"
            if not string match -q "$__pipenv_fish_initial_pwd"/'*' "$PWD/"
                set -U __pipenv_fish_final_pwd "$PWD"
                exit
            end
            return
        end

        if not test -n "$PIPENV_ACTIVE"
          if pipenv --venv >/dev/null 2>&1
            set -x __pipenv_fish_initial_pwd "$PWD"
            pipenv shell
            set -e __pipenv_fish_initial_pwd
            if test -n "$__pipenv_fish_final_pwd"
                cd "$__pipenv_fish_final_pwd"
                set -e __pipenv_fish_final_pwd
            end
          end
        end
    end
else
    function pipenv -d "http://docs.pipenv.org/en/latest/"
        echo "Install http://docs.pipenv.org/en/latest/ to use this plugin." > /dev/stderr
        return 1
    end
end
