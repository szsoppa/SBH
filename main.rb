require_relative 'class/graph'

graph = Graph.new
graph.initialize_graph 'dane'
graph.read_sequence 'sekwencja'
graph.build_arcs
graph.sort_arcs
#graph.show
graph.ant_colony
