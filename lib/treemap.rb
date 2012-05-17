require 'treemap'
class LinkedHtmlOutput < Treemap::HtmlOutput
  attr_accessor :tags
  def node_label(node)
    label = CGI.escapeHTML(node.label)
    if tags.has_key?(node.label)
      "<a class=\"tagcolor-#{tags[node.label]}\" href=\"/sitemap/tags/\##{node.label}\">#{label}</a>"
    else
      label
    end
  end
end
