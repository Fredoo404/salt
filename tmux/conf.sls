/usr/local/sbin/tmux-adm.sh:
  file.managed:
    - source: salt://tmux/files/tmux-adm.sh
    - template: jinja
    - mode: 777
    - makedirs: True