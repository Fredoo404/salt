{% for server, addrs in salt['mine.get']('*', 'internal_ip', 'compound').items() %}
{{ server }}:
  host.present:
    - ip: {{ addrs }}
{% endfor %}
