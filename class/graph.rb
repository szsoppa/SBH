require_relative 'node'
require_relative 'algorithm'

class Graph
  include Algorithm
  attr_accessor :nodes, :n, :l, :start_node

  def initialize
    self.nodes = Hash.new
    self.n = 0
    self.l = 0
  end

  def initialize_graph(path)
    File.open('data/'+path, 'r') do |f|
      f.each_line do |line|
        line.delete!("\n")
        self.start_node = line if self.l.zero?
        self.l = line.length if self.l.zero?
        return false if self.l != line.length
        assign_node(line)
      end
    end
  end

  def read_sequence(path)
    File.open('data/'+path, 'r') do |f|
      f.each_line do |line|
        line.delete!("\n")
        self.n = line.length
        self.start_node = line[0..self.l-1]
      end
    end
  end

  def build_arcs
    self.nodes.each do |key1, value1|
      self.nodes.each do |key2, value2|
        next if key1 == key2
        weight = get_match(key1, key2)
        next if weight.zero?
        nodes[key1].add_arc(Arc.new(weight,nodes[key2]))
      end
    end
  end

  def sort_arcs
    self.nodes.each do |key, value|
      value.arcs.sort! {|x,y| y.weight <=> x.weight}
    end
  end

  def show
    self.nodes.each do |key, value|
      print "#{value.code}: "
      value.arcs.each { |v| print "#{v.successor.code}(#{v.weight}) "}
      puts ''
    end
  end

  def ant_colony
    x = greedy(nodes, self.start_node, self.n)
    sequence = ''
    x.each do |oligo|
      if sequence.length == 0
        sequence += oligo
        next
      end
      match = get_match(sequence[sequence.length-self.l..-1], oligo)
      sequence += oligo[match..-1]
    end
    puts sequence if sequence != ''
  end

  private

  def assign_node(code)
    if nodes.has_key?(code)
      self.nodes[code].increment_repetitions
    else
      self.nodes[code] = Node.new(code)
    end
  end

  def get_match(oligo1, oligo2)
    for i in (0..oligo1.length-1) do
      if oligo1[i..-1] == oligo2[0..(oligo2.length-i-1)]
        return oligo1[i..-1].length
      end
    end
    return 0
  end

  def get_match_string(oligo1, oligo2)
    for i in (0..oligo1.length-1) do
      if oligo1[i..-1] == oligo2[0..(oligo2.length-i-1)]
        return oligo1[i..-1]
      end
    end
    return ''
  end
end