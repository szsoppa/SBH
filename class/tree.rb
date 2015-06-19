require_relative 'leaf'
require_relative 'graph'

class Tree
  attr_accessor :root, :list, :min

  def initialize(graph, path, constraint)
    self.list = Array.new
    self.min = -1
    Leaf.new(graph, self, path, constraint, 0)
  end


end
