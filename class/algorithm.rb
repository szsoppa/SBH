require 'pry'
module Algorithm
  def greedy(nodes, start, n)
    cost = 0
    path = []
    visited_arcs = []
    node = nodes[start]
    l = node.code.length
    len_n = 1
    path_weight = 0
    path << node.code
    while cost < n do
      arc = choose_next_arc(node)
      return [] if arc.nil?
      visited_arcs << arc
      len_n += 1
      path_weight += arc.weight
      path << nodes[arc.successor.code].code
      cost = (len_n * l) - path_weight
      node = arc.successor
      node.visited += 1
    end
    if cost == n && path.all? {|n| nodes[n].proper? }
      visited_arcs.each {|x| x.pheromone += 0.05}
      return path
    else
      return []
    end
  end

  private

  def choose_next_arc(node)
    return node.arcs.first if node.arcs.size == 1
    current_arcs = node.arcs.select {|a| a if a.successor.active? }
    return nil if current_arcs.size == 0
    heuristics = []
    current_arcs.each do |arc|
      heuristics << get_heuristic(arc).round(2)
    end
    sum = heuristics.reduce(:+)
    heuristics.map! {|h| h = h/sum}
    heuristics.unshift(0.0)
    for index in (1..heuristics.length-1) do
      heuristics[index] = heuristics[index-1] + heuristics[index]
    end
    rand_h = rand(0.0...1.0)
    for index in (0..heuristics.length-2) do
      return current_arcs[index] if rand_h >= heuristics[index] && rand_h < heuristics[index+1]
    end
  end

  def get_heuristic(arc)
    l = arc.successor.code.length
    (arc.pheromone * (arc.weight))/(l -1)
  end
end