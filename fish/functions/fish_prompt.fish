function fish_prompt
	if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end

    function _is_git_repo
      type -q git; or return 1
      git status -s >/dev/null ^/dev/null
    end

    function _hg_branch_name
      echo (hg branch ^/dev/null)
    end

    function _is_hg_dirty
      echo (hg status -mard ^/dev/null)
    end

    function _is_hg_repo
      type -q hg; or return 1
      hg summary >/dev/null ^/dev/null
    end

    function _repo_branch_name
      eval "_$argv[1]_branch_name"
    end

    function _is_repo_dirty
      eval "_is_$argv[1]_dirty"
    end

    function _repo_type
      if _is_hg_repo
        echo 'hg'
      else if _is_git_repo
        echo 'git'
      end
    end
  end

  function _miliseconds_to_human_readable
    set -l seconds_total (math "$argv[1] / 1000" )
    set -l hours (math "$seconds_total / 3600")
    set -l minutes (math "($seconds_total - 3600*$hours) / 60")
    set -l seconds (math "$seconds_total - 3600*$hours - 60*$minutes")

    if [ $hours -ne 0 ]
      set result {$hours}h {$minutes}m {$seconds}s
    else if [ $minutes -ne 0 ]
      set result {$minutes}m {$seconds}s
    else
      set result {$seconds}s
    end
    echo "$result"
  end

  function _go_part
    type -q g; or return 1
    set navrev (g navrev); or return 1
    echo $navrev
  end

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)


  set -l arrow "$red➜ "
  if [ $USER = 'root' ]
    set arrow "$red# "
  end

  set -l go_part (_go_part)
  if [ $go_part ]
    set go_info "$blue [$green$go_part$blue]"
  end

  set -l cwd $cyan(basename (prompt_pwd))

  set -l repo_type (_repo_type)
  if [ $repo_type ]
    set -l repo_branch $red(_repo_branch_name $repo_type)
    set repo_info "$blue $repo_type:($repo_branch$blue)"

    if [ (_is_repo_dirty $repo_type) ]
      set -l dirty "$yellow ✗"
      set repo_info "$repo_info$dirty"
    end
  end

  set notify_duration 10000
  set -q last_duration
  if [ $status -eq 0 -a "$last_duration" -gt "$notify_duration" ]
    set -g duration_string (set_color 555) "[" (_miliseconds_to_human_readable $last_duration) "] " (set_color normal)
  else
    set -g duration_string ""
  end

  echo -n -s $duration_string $arrow ' '$cwd $go_info $repo_info $normal ' '
end
