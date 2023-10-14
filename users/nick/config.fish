#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
if command -sq 1password
  or command -sq op
  set -gx SSH_AUTH_SOCK $HOME/.1password/agent.sock
else
  eval $(ssh-agent -c)
end

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
# Do not show any greeting
set --universal --erase fish_greeting
