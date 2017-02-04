common-pkgs:
  pkg.installed:
    - pkgs:
      - ack
      - git
      - tcpdump
      - tig
      - unzip
      - vim-enhanced

dotfile-download:
  cmd.run:
    - name: 'git clone https://github.com/Fredoo404/dotfiles.git /tmp/dotfile'

z-download:
  cmd.run:
    - name: 'wget https://github.com/rupa/z/archive/master.zip --directory-prefix=/tmp'

z-unzip:
  cmd.run:
    - name: 'unzip /tmp/master.zip -d /tmp'

z-config:
  cmd.run:
    - name: 'mkdir -p {{ pillar[common][home] }}/.zdb && mv /tmp/z-master/z.sh {{ pillar[common][home] }}/.zdb'