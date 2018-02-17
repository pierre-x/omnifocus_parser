require 'omnifocus_parser/version'
require 'omnifocus_parser/node_collection'
require 'rexml/document'
require 'rgl/adjacency'
require 'rgl/traversal'
require 'rgl/dot'

module OmnifocusParser
  attr_accessor :graph

  def xml_file=(xml_file)
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

      # append the new node to the graph
      #puts "node_id : #{node_id}"
      #puts "parent_node : #{parent_task_id}"
      node        = @nodes.create_node node_id, description
      parent_node = @nodes.get_node_by_id parent_task_id
      @graph.add_edge parent_node, node
    end
  end # def xml_file=

  def get_root_node
    @nodes.get_root_node
  end

end
