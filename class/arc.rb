class Arc
  attr_accessor :weight, :visited, :successor

  def initialize(weight, successor)
    self.weight = weight
    self.successor = successor
    self.visited = 0
  end


end