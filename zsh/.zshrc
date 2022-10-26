export ZSH="$HOME/.oh-my-zsh" ZSH_THEME="agnoster"

# removes computer name
DEFAULT_USER=$(whoami)

# PLUGINS
plugins=(
  git
  zsh-autosuggestions
)

#source $ZSH/oh-my-zsh.sh

if [ -f ~/.zsh/config/aliases ]; then
    . ~/.zsh/config/aliases
fi

if [ -f ~/.zsh/config/uncommittable_aliases ]; then
    . ~/.zsh/config/uncommittable_aliases
fi

if [ -f ~/.zsh/config/hidden_exports ]; then
    . ~/.zsh/config/hidden_exports
fi

if [ -f ~/.zsh/config/configs ]; then
    . ~/.zsh/config/configs
fi


#DISABLE_KUBE_PS1=true

#export HELM_EXPERIMENTAL_OCI=1

#export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin/:$PATH"
#export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
#export PATH="/usr/local/opt/helm@2/bin:$PATH"
#export PATH="/usr/local/opt/llvm/bin:$PATH"
#export PATH="/usr/local/opt/curl/bin:$PATH"
#export PATH=~/.nimble/bin:$PATH

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/local/bin/vault vault


#alias luamake=/Users/aaronarinder/external-code/lua-language-server/3rd/luamake/luamake
#alias helm3="/usr/local/opt/helm@3/bin/helm"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aaronarinder/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aaronarinder/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/aaronarinder/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aaronarinder/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
