def print_parents(item, items)
  all = []
  while item[:parent] != nil
    item = items.find{|i| i.identifier == item[:parent]}
    if item == nil
      break
    end
    all << item
  end
  all.reverse_each {|i|yield(i)}
end
