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
