set __one_color_orange ffa641 #   #FD971F
set __one_color_blue 5DC8FD #     #5dc8fd
set __one_color_deepblue 6caeff #     #6caeff
set __one_color_green 3ee771 #    #A6E22E
set __one_color_lgreen 2BED9B #   #2bed9b
set __one_color_yellow fff788 #   #E6DB7E
set __one_color_pink F92672 #     #F92672
set __one_color_red F76363 #      #ff4747
set __one_color_grey 747C81 #     #646a6e
set __one_color_white ebeef0 #    #F1F1F1
set __one_color_purple 9458FF #   #9458FF
set __one_color_lilac AE81FF #    #AE81FF

set -g __one_new_session 1

function __one_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function __one_current_folder
  if test $PWD = '/'
    echo -n '/'
  else
    echo -n $PWD | grep -o -E '[^\/]+$'
  end
end

function __one_git_status_codes
  echo (git status --porcelain 2>/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __one_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD 2>/dev/null)
end

function __one_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __one_color_echo $argv[2] ' '$argv[3]
  end
end

function __one_git_status_icons
  set -l git_status (__one_git_status_codes)

  __one_rainbow $git_status $__one_color_red 'D' # Deleted
  __one_rainbow $git_status $__one_color_orange 'R' # Renamed
  __one_rainbow $git_status $__one_color_white 'C' # Copied
  __one_rainbow $git_status $__one_color_lgreen 'A' # Added
  __one_rainbow $git_status $__one_color_blue 'U' # Updated but unmerged
  __one_rainbow $git_status $__one_color_lilac 'M' # Modified
  __one_rainbow $git_status $__one_color_grey '?' # Untracked
end

function __one_git_status
  # In git
  if test -n (__one_git_branch_name)

    # __one_color_echo $__one_color_blue " git"
	__one_color_echo $__one_color_white " ⎇ "
    __one_color_echo $__one_color_white (__one_git_branch_name)

    if test -n (__one_git_status_codes)
      __one_git_status_icons
    else
      __one_color_echo $__one_color_lgreen ' ○'
    end
  end
end

function __git_ahead -d 'Check if there are unpulled or unpushed commits'
  if set -l ahead_or_behind (command git rev-list --count --left-right 'HEAD...@{upstream}' 2> /dev/null)
    echo $ahead_or_behind | sed 's|\s\+|\n|g'
  else
    echo 0\n0
  end
end

function __check_ssh
  if [ "$SSH_CONNECTION" != "" ]
    set -l host (hostname -s)
    set -l user (whoami)

    if [ "$user" = "root" ]
      __one_color_echo $__one_color_yellow $user
	  __one_color_echo $__one_color_grey $host
    else
      __one_color_echo $__one_color_grey ' '$user
	  __one_color_echo $__one_color_grey '@'$host
    end
  end
end

function fish_prompt
  set -g last_status $status
  set -l git_ahead_behind (__git_ahead)

  if test $__one_new_session -eq 0
	if [ "$history[1]" != "clear" ]
    	echo
	end
  end

  __one_color_echo $__one_color_blue (prompt_pwd)
  __check_ssh
  __one_git_status
  if [ $git_ahead_behind[1] -gt 0 ]
    set_color -o $budspencer_colors[5]
    __one_color_echo $__one_color_deepblue ' ⇡ '$git_ahead_behind[1]
  end
  if [ $git_ahead_behind[2] -gt 0 ]
    __one_color_echo $__one_color_deepblue ' ⇣ '$git_ahead_behind[2]
  end
  echo
  set -l uid (id -u $USER)
  if test $uid -eq 0
    __one_color_echo $__one_color_yellow "❯❯ "
  else if test $last_status -ne 0
    __one_color_echo $__one_color_red "❯ "
  else
  	__one_color_echo $__one_color_lgreen "❯ "
  end
  set __one_new_session 0
end
