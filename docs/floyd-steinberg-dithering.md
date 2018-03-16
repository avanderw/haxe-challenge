{% assign crumbs = page.url | remove:'/index.html' | split: '/' %}
[Home](/haxe-challenge)
{% for crumb in crumbs offset: 1 %}{% if forloop.last %} / {{ crumb | replace:'-',' ' | remove:'.html' | capitalize }} {% else %} / [{{ crumb | replace:'-',' ' | remove:'.html' | split: " " | join: "-----" | capitalize | split: "-----" | join: " " }}]({% assign crumb_limit = forloop.index | plus: 1 %}{% for crumb in crumbs limit: crumb_limit %}{{ crumb | append: '/' }}{% endfor %}"){% endif %}{% endfor %}

# Floyd Steinberg Dithering

some text