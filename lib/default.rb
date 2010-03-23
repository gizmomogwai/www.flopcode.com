# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Filters
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

def traverse_items(items, tree_element, item_element, &code)
  capture_haml do
    items.each do |item|
      haml_tag item_element do
        code.call(item)
        if item.children.size > 0
          haml_tag tree_element do
            haml_concat traverse_items(item.children, tree_element, item_element, &code)
          end
        end
      end
    end
  end
end
