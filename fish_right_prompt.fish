set __one_color_orange FD971F #   #FD971F
set __one_color_blue 6EC9DD #     #6EC9DD
set __one_color_green A6E22E #    #A6E22E
set __one_color_yellow E6DB7E #   #E6DB7E
set __one_color_pink F92672 #     #F92672
set __one_color_grey 554F48 #     #554F48
set __one_color_white F1F1F1 #    #F1F1F1
set __one_color_purple 9458FF #   #9458FF
set __one_color_lilac AE81FF #    #AE81FF

function __one_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function fish_right_prompt
  __one_color_echo $__one_color_grey (node --version)
  __one_color_echo $__one_color_grey " | "(date "+%I:%M %p")
end
