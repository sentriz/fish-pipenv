![](https://i.imgur.com/BALScDM.png)

<p style="max-width: 75%;">hooks into a change in <code>PWD</code> to automatically launch a <a href="http://docs.pipenv.org/en/latest/">Pipenv</a> shell for your Pipenv project 

<p align="right" style="margin-left: auto; max-width: 75%; font-size: 14px; color: #eee;"><i>note:</i> this project was previously maintained by <a href="https://github.com/kennethreitz/">@kennethreitz</a></p>

## Installation


|manager|command|
|---|---|
|[fundle](https://github.com/danhper/fundle)|`fundle plugin 'sentriz/fish-pipenv'`|
|[fisher](https://github.com/jorgebucaran/fisher)|`fisher add 'sentriz/fish-pipenv'`|
|[oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)|`omf install 'https://github.com/sentriz/fish-pipenv'`|

## Configuration options
Suitable for your `~/.config/fish/config.fish`  

```fish
# set if your term supports `pipenv shell --fancy`
set pipenv_fish_fancy yes 
```

## Potential Issues
### Mac OS
After installing pipenv, running the `$ pipenv` command may yield the following error:  
`Install http://docs.pipenv.org/en/latest/ to use this package.`

### Reason for the error
The problem is that, the pipenv package rightly could not find the `pipenv` command. The situation with 
fish shell is that it executes scripts in the `/Users/user/.config/fish/config.d` folder before 
executing `config.fish` and the pipenv package creates a link in the config.d folder hence it is 
executed before config.fish.

Now depending on how you installed pipenv or how soon your `$PATH` is loaded you could be faced with the
above error.

### Solutions
1. You could install pipenv with the command `$ pip3 install pipenv`. Pipenv will then be installed in
    `/usr/local/bin`. On some systems the folder `/usr/local/bin` is added to $PATH by the system which
    means that it will be available before fish goes fishing for scripts in `/Users/user/.config/fish/config.d`
    
2. Or you could create a file say 000-env.fish (or whatever you want to call it), and place it in 
    `/Users/user/.config/fish/config.d`. In this file set the path to the folder where pipenv was installed. 
    E.g if pipenv was installed via pipsi, then the command will be something like 
    `set -x PATH /Users/user/.local/bin $PATH`
    
    If pipenv was installed via `$ pip install pipenv`, then note that pip (python2) now puts its executables
    in `/usr/local/opt/python/libexec/bin`.
    
    The `000` preface is to ensure that, that script will be executed first before the others in config.d. You
    don't have to prefix the file with `000` it is abitrary. Just give it a name that places it at the to of the
    pile.

3. Or assuming you also have [fish-pyenv](https://github.com/daenney/pyenv) you can add a universal variable to
    your `fish_user_paths` following
    [mhugbin](https://github.com/kennethreitz/fish-pipenv/issues/1#issuecomment-385206132):

    ```fish
    set -U fish_user_paths ~/.pyenv/shims $fish_user_paths
    ```
    
See https://github.com/sentriz/fish-pipenv/issues/1
