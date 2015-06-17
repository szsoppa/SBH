require_relative 'graph'

class Leaf
  attr_accessor :graph, :cost, :path, :preceeding_leaf, :alive, :child_leaves, :max_length
  def initialize(new_graph, parent_leaf, path, max_length, cost)
    self.graph = new_graph
    self.path = path
    self.alive = 1
    self.max_length = max_length
    self.preceeding_leaf = parent_leaf
    self.cost = cost
    update_info
  end

  def sprout_leaves
    self.child_leaves = Array.new
    self.path[-1].arcs.each do | arc | #TODO metoda zwracająca ostatni node w scieżce
      new_path = self.path.dup
      new_path.push(self.graph.nodes[arc.successor.code])
      tmp_cost = self.cost + arc.weight
      tmp_leaf = Leaf.new(self.graph, self, new_path, self.max_length, tmp_cost)
      self.child_leaves.push(tmp_leaf)
    end
    self.alive = 0
  end

  def initialize_sprouting
    if self.alive==1
      self.sprout_leaves
    elsif self.child_leaves !=nil
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
    self.path.count
    f = (self.path.count * path[0].code.length) - self.cost
    if f==max_length
      print f
      print ' '
      print_path
    elsif f>max_length
      self.alive=0
    end
  end

  def check_alive
    if self.alive==1
      return 1
      puts 'return 1'
    elsif self.child_leaves!=nil
      self.child_leaves.each do | child |
        if child.check_alive==1
          return 1
        end
    end
    else
    # puts 'return 0'
    return 0
    end
  end

end
