# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'haml'
#Haml::Options.defaults[:ugly] = true
require 'sass'
include Nanoc::Filters
use_helper Nanoc::Helpers::Filtering
use_helper Nanoc::Helpers::Rendering
use_helper Nanoc::Helpers::LinkTo

def wrap_with(s)
  "<#{s}>#{yield}</#{s}>"
end

def traverse_items(items, tree_element, item_element, &code)
  result = ""
  items.each do |item|
    result += wrap_with(item_element) do
      res = code.call(item)
      childs = item.children.reject{|i|i.binary?}
      if childs.size > 0
        res += wrap_with(tree_element) do
          traverse_items(childs, tree_element, item_element, &code)
        end
      end
      res
    end
  end
  result
end
  #result = ""
  #items.each do |item|
  #  puts "working on #{item[:title]}"
  #  result = "#{result}, #{item[:title]}"
  #  childs = item.children.reject{|i|i.binary?}
  #  result = "#{result}, #{traverse_items(childs, tree_Element, item_element, &code)}"
  #end
  #result
  #items.each do |item|
  #  "blub"#code.call(item)
  #end
  #capture do
#    require 'byebug'; byebug
#    items.each do |item|
#      content_tag item_element do
#        code.call(item)
#        childs = item.children.reject{|i|i.binary?}
#        if childs.size > 0
#          content_tag tree_element do
#            haml_concat traverse_items(childs, tree_element, item_element, &code)
#          end
#        end
#      end
#      #   end
#    end
#  end

def link(item)
  return "<a href=\"#{item.reps[:default].path}\">#{item[:title]}</a>"
end
