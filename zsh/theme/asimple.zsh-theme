#!/usr/bin/env zsh

# Based on Geoffrey Grosenbach's peepcode zsh theme from
# https://github.com/topfunky/zsh-simple
#

git_p() {
  echo $(git branch -v 2>/dev/null | head -n 1)
}

input_character() {
  input_char="%(!.#.»)%{$reset_color%}"
  color="%{$fg[$1]%}"
  echo "${color}${input_char}"
}
local input_indicator="%(?,$(input_character green),$(input_character red)%{$reset_color%})"

PROMPT='%~
${input_indicator}  %{$reset_color%}'

RPROMPT='%{$fg[white]%} $(git_p)%{$reset_color%}'
