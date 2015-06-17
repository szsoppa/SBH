require_relative 'class/graph'

graph = Graph.new
graph.initialize_graph 'dane'
graph.build_arcs
graph.sort_arcs
graph.show

