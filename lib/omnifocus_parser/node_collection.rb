require 'omnifocus_parser/node'

class NodeCollection
  attr_accessor :nodes

  def initialize
     @nodes = []
  end

  def get_node_by_id(node_id)
     node = nil
     @nodes.each do |node_iterator|
       if node_iterator.node_id == node_id
          node = node_iterator
          break;
       end
     end

     # if the node don't exist, create it
     if node.nil?
#       puts "creation du node #{node_id}"
       node = Node.new node_id
       @nodes.push node # append the new node to the collection
#     else
#       puts "node déjà existant #{node_id}"
     end

     node
  end

  def create_node(node_id,  name=nil, note=nil)
#    puts ""
#    puts "creation du nom : #{name}"
    node = get_node_by_id node_id

    node.name = name unless name.nil?
    node.note = note unless note.nil?

    p node

    node
  end

  def get_root_node
    @nodes.each do |node|
      return node if node.node_id == 'ROOT'
    end
  end

end
