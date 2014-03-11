include Nanoc::Helpers::Tagging

def get_parents(item, items)
  all = []
  while item[:parent] != nil
    item = items.find{|i| i.identifier == item[:parent]}
    if item == nil
      break
    end
    all << item
  end
  return all.reverse
end

def screenshots(items)
  res = ""
  items.children.each do |i|
    if i[:extension] == 'png'
      res += "<img src=\"#{i.identifier.chop}.png\" width=\"200px\" />"
    end
  end
  if res.length == 0
    return res
  end
  return "<a class=\"header\">Screens</a><div class=\"chapter\">#{res}</div>"
end

def do_collection(collection, context, first, last)
  collection.each_with_index do |i, idx|
    help = context.dup
    is_first = (idx == 0)
    is_last = (idx == (collection.size-1))
    if is_first
      help = "#{help}#{first}"
    end
    if is_last
      help = "#{help}#{last}"
    end
    yield(i, help, is_first, is_last )
  end
end

def lorem
  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
end

def content_items(items)
  items.reject{|i|i.binary?}
end

def tags_with_count(items)
  items.inject({}) do |acc, i|
    tags = i[:tags] || []
    tags.each do |t|
      current = acc[t] || 0
      acc[t] = current + 1
    end
    acc
  end
end

def items_with_tag_sorted(key)
  items_with_tag(key).sort{|a, b| a[:title] <=> b[:title] }
end

def disqus_link(item)
  return "<a id=\"toggle_disqus_thread\" data-disqus-identifier=\"#{item[:title]}\">Comments</a>"
end

def disqus_script(domain, id)
<<-eos
var disqus_identifier = '#{id}';
var disqus_shortname = '#{domain}';
(function() {
   var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
   dsq.src = '//#{domain}.disqus.com/embed.js';
   (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();
eos
end

def disqus_count(domain)
<<-eos
var disqus_shortname = '#{domain}';
(function () {
  var s = document.createElement('script'); s.async = true;
  s.type = 'text/javascript';
  s.src = 'http://#{domain}.disqus.com/count.js';
  (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
}());
eos
end
