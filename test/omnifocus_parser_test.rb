require "test_helper"

class OmnifocusParserTest < Minitest::Test
  
  include OmnifocusParser
  
  def test_that_it_has_a_version_number
    refute_nil ::OmnifocusParser::VERSION
  end

# TODO make better test
# contents.xml is not commited yet, because it contains my personnal TODO list
  def test_show_a_simple_parse
    self.xml_file= File.new('test/contents.xml')
    root_node = self.get_root_node
    disp_node root_node, 0

  end

  # recursive function to display the entire graph
  def disp_node(node, depth)
    depth.times {print '  '}
    puts "- #{node.text}"
    self.graph.each_adjacent node do |adj_node|
      disp_node adj_node, depth+1
  #   disp_node node
    end
  end

end
