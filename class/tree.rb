require_relative 'leaf'
require_relative 'graph'

class Tree
  attr_accessor :root
  
  def initialize(graph, path)
    self.root = Leaf.new(graph, nil, path)
  end

  def run
    self.root.initialize_sprouting
  end

end
