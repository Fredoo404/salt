tmux:
  pkg.installed

/usr/local/etc/tmux-adm/tmux.conf:
  file.managed:
    - source: salt://tmux/files/tmux.conf