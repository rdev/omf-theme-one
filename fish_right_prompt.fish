set __one_color_orange FD971F #   #FD971F
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
set __one_color_node 5a7c59 #    #AE81FF

function __one_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function fish_right_prompt
  __one_color_echo $__one_color_node "⬢ "(node --version)
  __one_color_echo $__one_color_white ""
end
