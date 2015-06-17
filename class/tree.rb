require_relative 'leaf'
require_relative 'graph'

class Tree
  attr_accessor :root

  def initialize(graph, path, constraint)
    self.root = Leaf.new(graph, nil, path, constraint, 0)
  end

  def run
    flag = 1
    while flag ==1 do
    flag = self.root.check_alive
    self.root.initialize_sprouting
    end
    puts 'method ended'
  end

end
