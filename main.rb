require_relative 'class/graph'
require 'csv'

file = ARGV[0].to_s

CSV.open("times.csv", "a+") do |csv|
  csv << ['data', 'time', 'errors']
end

Dir.foreach('./data/spectrum') do |folder|
  next if folder == '.' or folder == '..'
  Dir.foreach('./data/spectrum/'+folder) do |file|
    next if file == '.' or file == '..'
    graph = Graph.new
    graph.initialize_graph 'spectrum/'+ folder + '/' + file
    graph.read_sequence 'sequence/' + folder + '/' + file
    graph.build_arcs
    graph.sort_arcs

    t1 = Time.now
    seq, score = graph.ant_colony
    t2 = Time.now
    delta = t2 - t1
    # puts seq
    # puts score
    # puts delta
    CSV.open("times.csv", "a+") do |csv|
      csv << [file+'('+folder+')', delta.to_s, score.to_s]
    end
  end
end


#puts seq