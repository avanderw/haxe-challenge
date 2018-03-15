#haxe challenge

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | absolute_url }}">{{ post.title }}</a>
	  {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>


<ul>
  {% for category in site.categories %}
  {{ category.category }}
    <li>
      <a href="{{ category.url | absolute_url }}">{{ category.title }}</a>
	  {{ category.excerpt }}
    </li>
  {% endfor %}
</ul>
