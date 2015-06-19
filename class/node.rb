require_relative 'arc'

class Node
  attr_accessor :repetitions, :visited, :arcs, :code

  def initialize(code)
    self.code = code
    self.visited = 0
    self.repetitions = 1
    self.arcs = Array.new
  end

  def add_arc(arc)
    self.arcs << arc
  end

  def increment_visited
    self.visited += 1
  end

  def decrement_visited
    self.visited -= 1
  end

  def increment_repetitions
    self.repetitions += 1
  end

  def print_arcs
    print "#{self.code}: "
    self.arcs.each { |a| print "#{a.weigth} "}
  end

  def active?
    free = repetitions - visited
    if free >= 0
      return true
    elsif free == -1 && repetitions != 0
      return true
    elsif (free == -2 && ([2,4,5].include?(repetitions))) || repetitions > 5
      return true
    else
      return false
    end
  end

  def proper?
    free = repetitions - visited
    if free < 0
      return true
    elsif free == 0 || free == 1
      return true
    elsif free == 2 && repetitions >= 3
      return true
    elsif free == 3 && repetitions >= 5 && repetitions != 6
      return true
    elsif free > 3 &&  visited >= 4
      return true
    else
      return false
    end
  end

  def error?
    if repetitions == 0 && visited != 0
      return true
    elsif repetitions == 1 && visited != 1
      return true
    elsif (repetitions == 2 || repetitions == 3) && (visited != 2 && visited != 3)
      return true
    elsif (repetitions == 4 || repetitions == 5) && (visited != 4 && visited != 5)
      return true
    elsif repetitions > 5 && visited <= 5
      return true
    else
      return false
    end
  end

  def min_left
    left = 0
    if self.visited < self.repetitions
      if self.repetitions == 2 || self.repetitions == 3
        left = 1 - self.visited
      elsif self.repetitions == 4 || self.repetitions == 5
        left = 2 - self.visited
      elsif self.repetitions > 5
        left = 4 - self.visited
      end
    end
    if left > 1
       return left
    elsif left <= 0
      return 0
    else
      return left
    end
  end

end
