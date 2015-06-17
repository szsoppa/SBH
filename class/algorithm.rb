require 'pry'
module Algorithm
  def greedy(nodes, start, n)
    cost = 0
    node = nodes[start]
    while cost < 1 do
      arc = choose_next_arc(node)
      puts arc.weight
      cost+=1
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