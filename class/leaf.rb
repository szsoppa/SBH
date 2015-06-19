require_relative 'graph'

class Leaf
  attr_accessor :graph, :cost, :path, :alive, :max_length, :out
  def initialize(new_graph, out, path, max_length, cost)
    self.graph = new_graph
    self.path = path
    self.alive = 1
    self.max_length = max_length
    self.out = out
    self.cost = cost
    update_info
    sprout_leaves
  end

  def sprout_leaves
    if self.alive == 0
      return
    end
    self.path[-1].arcs.each do | arc |
      new_path = self.path.dup
      if self.graph.nodes[arc.successor.code].active? == true
      new_path.push(self.graph.nodes[arc.successor.code])
      tmp_cost = self.cost + arc.weight
      self.graph.nodes[arc.successor.code].increment_visited
      Leaf.new(self.graph, self.out, new_path, self.max_length, tmp_cost)
      self.graph.nodes[arc.successor.code].decrement_visited
      update_info
      if self.alive == 0
        return
      end
      end
    end
    self.alive = 0
  end

  def print_path
    self.path.each do | node |
      print "#{node.code} "
    end
    puts ''
  end

  def update_info

    f = (self.path.count * path[0].code.length) - self.cost
    if f<max_length
      tmp_error = 0
      ary = self.path.uniq{|x| x.code}
      ary.each do |x|
        if x.error?
          tmp_error += 1
        end
      end
      if tmp_error > (self.out.min*(max_length/f)*0.9) && self.out.min > 0
        self.alive = 0
        # print tmp_error
        # puts 'error cut'
        return
      end
    end
    if f<max_length
      left = 0
      self.graph.nodes.each do |key, node|
        left += node.min_left
        if left > 5
          # puts left
        end



        if (f + 5*left) > max_length
          self.alive = 0
          # puts 'cut off'
          return
        end
      end
    elsif f>max_length
      self.alive=0
      return
    elsif f==max_length
      error_count = 0
      self.graph.nodes.each do |key, node |
        if node.proper? == false
          return
        end
        if node.error? == true
          error_count += 1
        end
      end

      if error_count <= self.out.min || self.out.min == -1
        if error_count < self.out.min || self.out.min == -1
          self.out.min = error_count
          self.out.list.clear
          print 'new minimum '
          print error_count
          puts ''
        end
        self.out.list.push(self.path)
        # print ' list size'
        # print self.out.list.size
        # puts ''
      end
    end
  end


end
