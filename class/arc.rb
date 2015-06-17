class Arc
  attr_accessor :weight, :successor, :visited, :pheromone

  def initialize(weight, successor)
    self.weight = weight
    self.successor = successor
    self.visited = 0
    self.pheromone = 0.5
  end
end