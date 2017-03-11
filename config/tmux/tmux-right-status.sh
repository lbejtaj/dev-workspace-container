#!/bin/bash

path="$(tmux display-message -p -F "#{pane_current_path}")"

git_info=" "
if [ -d ${path}/.git ]; then
	git_info=$(cd ${path}; echo -n " ( "; git rev-parse --abbrev-ref HEAD; $(git diff-index --quiet HEAD -- || echo "* "); echo -n ") ")
fi

echo ${path}${git_info}$(date +"%H:%M")
