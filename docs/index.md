# haxe challenge

some text

<ul>
  {% for page in site.pages %}
    <li>
      <a href="{{ page.url | absolute_url }}">{{ page.title }}</a>
	  {{ page.excerpt }}
    </li>
  {% endfor %}
</ul>
