# haxe challenge

some text

<ul>
  {% for item in site.pages %}
    <li>
      <a href="{{ item.url | absolute_url }}">{{ item.title }} - {{item.url}}</a>
	  {{ item.excerpt }}
    </li>
  {% endfor %}
</ul>
