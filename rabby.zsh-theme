THEME_SUCCESS="green"
THEME_FAILURE="red"
THEME_TEXT="240"
THEME_VENV="121"
THEME_GIT="214"

autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:git:*' formats '%F{'$THEME_GIT'}%b%f'

function set_prompt() {
  local EXIT_STATUS=$?

  local venv_status=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_status="%F{${THEME_VENV}}(venv: ${VIRTUAL_ENV:t})%f "
  fi

  local git_status="${vcs_info_msg_0_}"

  local extra_info=""
  if [[ -n "$venv_status" || -n "$git_status" ]]; then
    extra_info="   -> ${venv_status}${git_status}"
  fi

  if [[ $EXIT_STATUS -eq 0 ]]; then
    PROMPT="
%F{${THEME_SUCCESS}}%B(\_/)%b%f      %F{${THEME_TEXT}}%n@%m   %?%f${extra_info}
%F{${THEME_SUCCESS}}%B( ^.^)%b%f     %F{${THEME_TEXT}}%~%f
%F{${THEME_SUCCESS}}%B/ >%b%f "
  else
    PROMPT="
%F{${THEME_FAILURE}}%B(\_/)%b%f      %F{${THEME_TEXT}}%n@%m   %?%f${extra_info}
%F{${THEME_FAILURE}}%B( ×_×)%b%f     %F{${THEME_TEXT}}%~%f
%F{${THEME_FAILURE}}%B/ >%b%f "
  fi
}
precmd_functions+=(set_prompt)

