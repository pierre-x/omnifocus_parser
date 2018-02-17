<<<<<<< HEAD
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
       node = Node.new node_id
       @nodes.push node # append the new node to the collection
     end

     node
  end

  def create_node(node_id, text=nil, comment=nil)
    node = get_node_by_id node_id
    node.text    = text    unless text.nil?
    node.comment = comment unless comment.nil?
    node
  end

=======

class NodeCollection
>>>>>>> c8861d0f554567e1c6878bd5edd506f2d9806800
end