require_relative 'class/graph'


graph = Graph.new
graph.initialize_graph 'spectrum/67'
graph.read_sequence 'sequence/340'
graph.build_arcs
graph.sort_arcs
#graph.show
puts graph.ant_colony
