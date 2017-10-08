/root/tmux-adm.sh:
  file.managed:
    - source: salt://tmux/files/tmux-adm.sh
    - template: jinja