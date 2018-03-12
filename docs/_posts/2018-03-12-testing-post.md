---
title:  "Welcome to Jekyll!"
date:   2018-03-12
categories: jekyll update
---

#testing post

{% highlight ruby %}
def show
  @widget = Widget(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @widget }
  end
end
{% endhighlight %}