require_relative 'node'

class Graph
  attr_accessor :nodes, :n, :l

  def initialize
    self.nodes = Hash.new
    self.n = 0
    self.l = 0
  end

  def initialize_graph(path)
    File.open('../data/'+path, 'r') do |f|
      f.each_line do |line|
        line.delete(' ')
        if self.l.zero?
          self.l = line.length
        else
          return false if self.l != line.length
        end
        assign_node(line)
        self.n += 1
      end
    end
  end

  def build_arcs
    self.nodes.each do |key1, value1|
      self.nodes.each do |key2, value2|
        next if key1 == key2
        weight = get_match(key1, key2)
        next if weight.zero?
        nodes[key1].add_arc(Arc.new(weight,key2))
      end
    end
  end

  def show
    self.nodes.each do |key, value|
      print key + ': '
      value.arcs.each { |v| print "#{x.successor}(#{v.weight}) "}
      puts ''
    end
  end

  private

  def assign_node(code)
    if nodes.has_key?(code)
      self.nodes[code].increment_repetitions
    else
      self.nodes[code] = Node.new
    end
  end

  def get_match(oligo1, oligo2)
    for i in (0..oligo1.length-1) do
      if oligo1[i..-1] == oligo2[0..(oligo2.length-i-1)]
        return oligo1[i..-1]
      end
    end
    return 0
  end
end