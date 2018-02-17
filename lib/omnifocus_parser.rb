require 'omnifocus_parser/version'
require 'omnifocus_parser/tree' # TODO old method, delete
require 'omnifocus_parser/node_collection'
require 'rexml/document'
require 'rgl/adjacency'
require 'rgl/dot' # to get a visual representation

module OmnifocusParser
  attr_accessor :tree

  def xml_file=(xml_file)
    @tree = Tree.new # TODO old method, delete
    @graph = RGL::DirectedAdjacencyGraph.new
    @nodes = NodeCollection.new

    xml_doc = REXML::Document.new xml_file
    xml_doc.elements.each("omnifocus/task") do |task|
      next if !task.elements['completed']&.first.nil? # skip completed task
      description = task.elements['name'].first.value # get description TODO rename to text
                                                      # TODO also get associated comments
      node_id     = task.attributes['id']             # get node id
      parent_task = task.elements['task']             # get parent task
      if parent_task # check if the task has a parent or is a root project
        parent_task_id = parent_task.attributes['idref']
        parent_task_id = 'INBOX' if parent_task_id.nil?
      else
        parent_task_id = 'ROOT'
      end

      # append to the tree
      tree.add_node(description, node_id, parent_task_id) # TODO old method, delete
      node        = @nodes.create_node node_id, description
      parent_node = @nodes.get_node_by_id parent_task_id

      @graph.add_edge parent_node, node
    end

    @graph.print_dotted_on # output a dot representation

    tree.compute_graph!
  end # def xml_file=

  def disp_node(node, level)
    # return # FIXME remove, for debug only
    level.times{print ' '}
  #  puts "- #{node.description}"
    node.children_nodes.each do |child|
      disp_node(child, level+3)
    end
  end

end
