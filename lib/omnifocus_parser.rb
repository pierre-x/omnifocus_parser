require "omnifocus_parser/version"
require "omnifocus_parser/tree"
require "rexml/document"

module OmnifocusParser
  attr_accessor :tree
  
  def xml_file=(xml_file)
      @tree = Tree.new
    
      xml_doc = REXML::Document.new xml_file
      xml_doc.elements.each("omnifocus/task") do |task|
          description = task.elements['name'].first.value
          next if !task.elements['completed']&.first.nil? # skip completed task
       #   puts description
          child_id = task.attributes['id']
       #   puts "this:   #{child_id}"
          parent_task =  task.elements['task']
          if parent_task
            parent_task_id = parent_task.attributes['idref']
            if parent_task_id
       #       puts "parent: #{parent_task_id}"
            else
              parent_task_id = 'INBOX'
       #       puts 'parent: inbox?'
            end
          end
          
          # append to the tree
          tree.add_node(description, child_id, parent_task_id)
       #   puts "     ---"
      end
      
      tree.compute_graph!
  end # def xml_file=
  
  def disp_node(node, level)
    level.times{print ' '}
    puts "- #{node.description}"
    node.children_nodes.each do |child|
      disp_node(child, level+3)
    end
    
  end
end
