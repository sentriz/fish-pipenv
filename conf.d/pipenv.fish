# set the user installation path

if command -s pipenv > /dev/null
    
    complete --command pipenv --arguments "(env _PIPENV_COMPLETE=complete-fish COMMANDLINE=(commandline -cp) pipenv)" -f
    
    function __pipenv_shell_activate --on-variable PWD
        if status --is-command-substitution
            return
        end
        if not test -e "$PWD/Pipfile"
            return
        end

        if not test -n "$PIPENV_ACTIVE"
          if sh -c 'pipenv --venv >/dev/null 2>&1'
            pipenv shell
          end
        end
    end
else
    function pipenv -d "http://docs.pipenv.org/en/latest/"
        echo "Install http://docs.pipenv.org/en/latest/ to use this plugin." > /dev/stderr
        return 1
    end
end
