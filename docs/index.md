{% assign crumbs = page.url | remove:'/index.html' | split: '/' %}
[Home](/haxe-challenge)
{% for crumb in crumbs offset: 1 %}{% if forloop.last %} / {{ crumb | replace: "-"," " | capitalize | remove:'.html'}} {% else %} / [{{ crumb | replace: "-"," " | capitalize | remove:'.html'}}]({% assign crumb_limit = forloop.index | plus: 1 %}{% for crumb in crumbs limit: crumb_limit %}{{ crumb | append: '/' }}{% endfor %}"){% endif %}{% endfor %}

# Haxe Challenge

some text

<ul>
    <li><a href="/haxe-challenge/floyd-steinberg-dithering">Floyd Steinberg Dithering</a></li>
	<li><a href="/haxe-challenge/median-cut">Median Cut</a></li>
	<li><a href="/haxe-challenge/color-quantization">Color Quantization</a></li>
</ul>
