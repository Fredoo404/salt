#!/bin/bash

function create_window() {
    local window_name
    local server

    window_name=$1
    server=$2

    tmux new-window -n "$window_name" "ssh $server"
    tmux send-keys "sudo -s" C-m
    tmux send-keys "clear" C-m
}


tmux -f /usr/local/etc/tmux-adm/tmux.conf new-session -d -s "Cloud" -n "adm"

{% for server, addrs in salt['mine.get']('*', 'internal_ip', 'compound').items() -%}
create_window "{{ server }}" "{{ addrs }}"
{% endfor %}

