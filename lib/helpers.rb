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
