class Node
   attr_accessor :text, :comment, :node_id

   def initialize(node_id, text=nil, comment=nil)
      @node_id = node_id
   end

end