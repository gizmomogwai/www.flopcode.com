# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'haml'
#Haml::Options.defaults[:ugly] = true
require 'sass'
include Nanoc::Filters
include Nanoc::Helpers::Filtering
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo

def traverse_items(items, tree_element, item_element, &code)
  capture_haml do
    items.each do |item|
      haml_tag item_element do
        code.call(item)
        childs = item.children.reject{|i|i.binary?}
        if childs.size > 0
          haml_tag tree_element do
            haml_concat traverse_items(childs, tree_element, item_element, &code)
          end
        end
      end
    end
  end
end

def link(item)
  # %a{:href=> "#{i.reps[:default].path}"} #{i[:title]}
  return "<a href=\"#{item.reps[:default].path}\">#{item[:title]}</a>"
end
