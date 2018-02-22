class Node
   attr_accessor :name, :node_id
   attr_reader   :note

   def initialize(node_id, name=nil, note=nil)
      @node_id = node_id
      @name    = name
      @note    = note
      @name = 'ROOT' if name.nil?
      @note = '' if note.nil?
      @note = @note.to_s
   end

   def note=(value)
    @note = value.to_s
   end
end