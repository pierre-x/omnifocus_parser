require "test_helper"

class OmnifocusParserTest < Minitest::Test
  
  include OmnifocusParser
  
  def test_that_it_has_a_version_number
    refute_nil ::OmnifocusParser::VERSION
  end

# TODO make better test
# sample.xml is not commited yet, because it contains my personnal TODO list
  def test_show_a_simple_parse
         self.xml_file= File.new('test/contents.xml')
         self.tree.root_nodes.each{|node| disp_node(node,0)}
  end       
         
end
