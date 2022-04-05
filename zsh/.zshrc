export ZSH="$HOME/.oh-my-zsh" ZSH_THEME="agnoster"

# removes computer name
DEFAULT_USER=$(whoami)

# PLUGINS
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

if [ -f ~/zsh/aliases ]; then
    . ~/zsh/aliases
fi

if [ -f ~/zsh/uncommittable_aliases ]; then
    . ~/zsh/uncommittable_aliases
fi

if [ -f ~/zsh/hidden_exports ]; then
    . ~/zsh/hidden_exports
fi

if [ -f ~/zsh/configs ]; then
    . ~/zsh/configs
fi

alias python=python3

DISABLE_KUBE_PS1=true
source /usr/local/bin/stockx_kubectl

export HELM_EXPERIMENTAL_OCI=1

#export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin/:$PATH"
#export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
#export PATH="/usr/local/opt/helm@2/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH=~/.nimble/bin:$PATH

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

. /usr/local/opt/asdf/libexec/asdf.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault


#alias luamake=/Users/aaronarinder/external-code/lua-language-server/3rd/luamake/luamake
#alias helm3="/usr/local/opt/helm@3/bin/helm"
