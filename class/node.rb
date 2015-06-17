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
end