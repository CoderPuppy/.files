export PATH="$HOME/.luaenv/bin:$PATH"
export PATH="/home/cpup/.luaenv/shims:${PATH}"
export LUAENV_SHELL=zsh
source '/home/cpup/.luaenv/completions/luaenv.zsh'
luaenv rehash 2>/dev/null
luaenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "`luaenv "sh-$command" "$@"`";;
  *)
    command luaenv "$command" "$@";;
  esac
}