module Algorithm
  def greedy(nodes, start, n)
    node = nodes[start]
    while cost < n do
      arc = choose_next_arc(node)
    end
  end

  private

  def choose_next_arc(node)
    heuristics = []
    node.arcs.each do |arc|
      heuristics << arc.pheromone
    end
  end

  def get_heuristic(nodes, arc)
    if arc.successor
    arc.pheromone * (arc.weight/(arc.successor.length -1))
    end
  end
end