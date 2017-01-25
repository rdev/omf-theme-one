set __one_color_orange FD971F #   #FD971F
set __one_color_blue 4BCBE7 #     #4bcbe7
set __one_color_green A6E22E #    #A6E22E
set __one_color_lgreen 2BED9B #   #2bed9b
set __one_color_yellow E6DB7E #   #E6DB7E
set __one_color_pink F92672 #     #F92672
set __one_color_red FF4747 #      #ff4747
set __one_color_grey 554F48 #     #554F48
set __one_color_white F1F1F1 #    #F1F1F1
set __one_color_purple 9458FF #   #9458FF
set __one_color_lilac AE81FF #    #AE81FF
set __su_glyph "[⚡︎] "

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
  echo (git status --porcelain ^/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __one_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function __one_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __one_color_echo $argv[2] "● "
  end
end

function __one_git_status_icons
  set -l git_status (__one_git_status_codes)

  __one_rainbow $git_status $__one_color_pink 'D' # Deleted
  __one_rainbow $git_status $__one_color_orange 'R' # Renamed
  __one_rainbow $git_status $__one_color_white 'C' # Copied
  __one_rainbow $git_status $__one_color_green 'A' # Added
  __one_rainbow $git_status $__one_color_blue 'U' # Updated but unmerged
  __one_rainbow $git_status $__one_color_lilac 'M' # Modified
  __one_rainbow $git_status $__one_color_grey '?' # Untracked
end

function __one_git_status
  # In git
  if test -n (__one_git_branch_name)

    __one_color_echo $__one_color_blue " git"
	__one_color_echo $__one_color_white "⎇ "
    __one_color_echo $__one_color_lgreen (__one_git_branch_name)

    if test -n (__one_git_status_codes)
      __one_color_echo $__one_color_pink ' '
      __one_git_status_icons
    else
      __one_color_echo $__one_color_green ' ○'
    end
  end
end

function __git_ahead -d 'Check if there are unpulled or unpushed commits'
  if set -l ahead_or_behind (command git rev-list --count --left-right 'HEAD...@{upstream}' ^ /dev/null)
    echo $ahead_or_behind | sed 's|\s\+|\n|g'
  else
    echo 0\n0
  end
end

function fish_prompt
  set -g last_status $status
  set -l git_ahead_behind (__git_ahead)

  __one_color_echo $__one_color_blue "# "
  __one_color_echo $__one_color_purple (prompt_pwd)
  __one_git_status
  if [ $git_ahead_behind[1] -gt 0 ]
    set_color -o $budspencer_colors[5]
    __one_color_echo $__one_color_purple ' ↑ '$git_ahead_behind[1]
  end
  if [ $git_ahead_behind[2] -gt 0 ]
    __one_color_echo $__one_color_purple ' ↓ '$git_ahead_behind[2]
  end
  echo
  set -l uid (id -u $USER)
  if test $uid -eq 0
    __one_color_echo $__one_color_yellow $__su_glyph
  end
  if test $last_status -ne 0
    __one_color_echo $__one_color_red "[!] "
  end
  __one_color_echo $__one_color_pink "\$ "
end
