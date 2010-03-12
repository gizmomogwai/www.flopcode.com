def print_parents(item, items, first, last)
  all = []
  while item[:parent] != nil
    item = items.find{|i| i.identifier == item[:parent]}
    if item == nil
      break
    end
    all << item
  end
  do_collection(all.reverse, 'parent', first, last) {|i, j|yield(i,j)}
end


def do_collection(collection, context, first, last)
  collection.each_with_index do |i, idx|
    help = context.dup
    if idx == 0
      help = "#{help}#{first}"
    end
    if idx == (collection.size-1)
      help = "#{help}#{last}"
    end
    yield(i, help)
  end
end
