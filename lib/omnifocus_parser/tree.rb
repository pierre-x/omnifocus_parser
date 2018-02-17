# FIXME ATTENTION IL Y A DES PARENTS_ID QUI SONT VIDES!!!

# This tree management is not optimised at all, but is a fast, quick, and dirty implementation that works!

class NodeOld
    attr_accessor :description
    attr_accessor :xml_id
    attr_accessor :xml_parent_id
    attr_accessor :parent_node
    attr_accessor :children_nodes

    def initialize(description, xml_id, xml_parent_id)
        @description    = description
        @xml_id         = xml_id
        @xml_parent_id  = xml_parent_id
        @children_nodes = []
        @parent_node    = nil
    end
    
end


class Tree
    attr_accessor :nodes
    attr_accessor :edges
    attr_accessor :root_nodes
    
    def initialize
        @nodes = []
        @root_nodes = []
    end
    
    def add_node(description, xml_id, xml_parent_id)
        @nodes << NodeOld.new(description, xml_id, xml_parent_id)
    end
    
    # create the link between nodes using xml_id and xml_parent_id
    def compute_graph!
        @nodes.each do |node|
            # find the parent
            @nodes.each do |another_node|
                # find parent
                if node.xml_parent_id == another_node.xml_id
                    node.parent_node = another_node
                end
                
                # find children
                if another_node.xml_parent_id == node.xml_id
                   node.children_nodes << another_node
                end
            end
            
            if node.parent_node.nil?
               @root_nodes << node
            end
            
        end
    end
    
end

