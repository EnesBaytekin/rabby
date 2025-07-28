function set_prompt() {
  if [[ $? -eq 0 ]]; then
    PROMPT="
%F{green}%B(\_/)%b%f      %F{240}%n@%m   %?%f
%F{green}%B( ^.^)%b%f     %F{240}%~%f
%F{green}%B/ >%b%f "
  else
    PROMPT="
%F{red}%B(\_/)%b%f      %F{240}%n@%m   %?%f
%F{red}%B( ×_×)%b%f     %F{240}%~%f
%F{red}%B/ >%b%f "
  fi
}
precmd_functions+=(set_prompt)

