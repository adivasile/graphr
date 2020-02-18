require 'graphr'

graph = Graphr::Graph.from_dot_file('spec/fixtures/graph.dot')

shortest_path = Graphr::Algorithms::ShortestPath.new graph

puts shortest_path.between("0", "7")
