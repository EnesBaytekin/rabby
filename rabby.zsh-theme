THEME_SUCCESS="green"
THEME_FAILURE="red"
THEME_TEXT="243"
THEME_VENV="121"
THEME_GIT="214"
THEME_TIME="117"

autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:git:*' formats '%F{'$THEME_GIT'}%b%f'

function x_preexec() {
  CMD_START=$EPOCHREALTIME
}
preexec_functions+=(x_preexec)

function set_prompt() {
  local EXIT_STATUS=$?
  
  local elapsed_time=""
  if [[ -n $CMD_START ]]; then
    local CMD_END=$EPOCHREALTIME
    local duration=$(print -f "%.2f" $(( CMD_END - CMD_START )))
    
    if (( $(echo "$duration > 1.0" | bc -l) )); then
      local int_duration=${duration%.*}
      
      if (( int_duration >= 60 )); then
        local mins=$(( int_duration / 60 ))
        local secs=$(( int_duration % 60 ))
        elapsed_time="%F{${THEME_TIME}}(${mins}m ${secs}s)%f "
      else
        elapsed_time="%F{${THEME_TIME}}(${duration}s)%f "
      fi
    fi
    unset CMD_START
  fi

  local venv_status=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_status="%F{${THEME_VENV}}(venv: ${VIRTUAL_ENV:t})%f "
  fi

  local git_status="${vcs_info_msg_0_}"

  local extra_info=""
  if [[ -n "$venv_status" || -n "$git_status" ]]; then
    extra_info=" | ${venv_status}${git_status}"
  fi

  if [[ $EXIT_STATUS -eq 0 ]]; then
    PROMPT="
%F{${THEME_SUCCESS}}%B(\_/)%b%f      %F{${THEME_TEXT}}%n@%m %f|  %F{${THEME_SUCCESS}}%?%f ${elapsed_time}${extra_info}
%F{${THEME_SUCCESS}}%B( ^.^)%b%f     %F{${THEME_TEXT}}%~%f
%F{${THEME_SUCCESS}}%B/ >%b%f "
  else
    PROMPT="
%F{${THEME_FAILURE}}%B(\_/)%b%f      %F{${THEME_TEXT}}%n@%m %f|  %F{${THEME_FAILURE}}%?%f ${elapsed_time}${extra_info}
%F{${THEME_FAILURE}}%B( ×_×)%b%f     %F{${THEME_TEXT}}%~%f
%F{${THEME_FAILURE}}%B/ >%b%f "
  fi
}
precmd_functions+=(set_prompt)
