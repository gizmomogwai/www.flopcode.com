# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'haml'
require 'sass'
include Nanoc3::Filters
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

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
  # %a{:href=> "#{i.reps[0].path}"} #{i[:title]}
  return "<a href=\"#{item.reps[0].path}\">#{item[:title]}</a>"
end
