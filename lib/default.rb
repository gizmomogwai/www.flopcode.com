# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Filters
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

def traverse_items(items)
  capture_haml do
    items.each do |item|
      haml_tag :li do
        haml_concat item[:title]
        if item.children.size > 0
          haml_tag :ul do
            haml_concat traverse_items(item.children)
          end
        end
      end
    end
  end
end
