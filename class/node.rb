require_relative 'arc'

class Node
  attr_accessor :repetitions, :visited, :arcs

  def initialize
    self.visited = 0
    self.repetitions = 0
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
end