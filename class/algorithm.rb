require 'pry'
module Algorithm
  def greedy(nodes, start, n)
    cost = 0
    path = []
    node = nodes[start]
    l = node.code.length
    len_n = 1
    path_weight = 0
    path << node.code
    while cost < n do
      arc = choose_next_arc(node)
      len_n += 1
      path_weight += arc.weight
      path << nodes[arc.successor.code].code
      cost = (len_n * l) - path_weight
      node = arc.successor
    end
    if cost == n
      return path
    else
      return []
    end
  end

  private

  def choose_next_arc(node)
    return node.arcs.first if node.arcs.size == 1
    current_arcs = node.arcs.map {|a| a if a.successor.active? }
    heuristics = []
    current_arcs.each do |arc|
      heuristics << get_heuristic(arc)
    end
    sum = heuristics.reduce(:+)
    heuristics.map! {|h| h = h/sum}
    heuristics.unshift(0.0)
    temp = [0]
    for index in (0..heuristics.length-2) do
      temp << heuristics[index] + heuristics[index+1]
    end
    heuristics = temp
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