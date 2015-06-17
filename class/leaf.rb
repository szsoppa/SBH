require_relative 'graph'

class Leaf
  attr_accessor :graph, :path, :preceeding_leaf, :alive, :child_leaves
  def initialize(new_graph, parent_leaf, path)
    self.graph = new_graph
    self.path = path
    self.alive = 1
    self.preceeding_leaf = parent_leaf
    print_path
  end

  def sprout_leaves
    self.child_leaves = Array.new
    self.path[-1].arcs.each do | arc | #TODO metoda zwracająca ostatni node w scieżce
      new_path = self.path.dup
      new_path.push(self.graph.nodes[arc.successor.code])
      tmp_leaf = Leaf.new(self.graph, self, new_path)
      self.child_leaves.push(tmp_leaf)
    end
    self.alive = 0
  end

  def initialize_sprouting
    if self.alive==1
      self.sprout_leaves
    else
      self.child_leaves.each do | leaf |
        leaf.initialize_sprouting
      end
    end
  end

  def print_path
    self.path.each do | node |
      print "#{node.code} "
    end
    puts ''
  end

  def update_info
    self.nucleotides_count = self.path.count
  end


end
