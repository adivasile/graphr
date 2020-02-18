require "spec_helper"
require "graphr"

describe Graphr::Graph do
  let (:nodes) { [{ id: 1 }, { id: 2 }, { id: 3 }] }
  let (:edges) { [{ from: 1, to: 2, weight: 4 }, { from: 2, to: 3, weight: 1 }] }
  subject { Graphr::Graph.new(nodes, edges) }

  context "interface" do

    it { is_expected.to respond_to(:find_node) }
    it { is_expected.to respond_to(:nodes) }
    it { is_expected.to respond_to(:edges) }
    it { is_expected.to respond_to(:neighbours_for) }
    it { is_expected.to respond_to(:each_node) }
  end

  context "#initialize" do
    it "should set properties" do
      expect(subject.nodes).to be_kind_of(Hash)
      expect(subject.edges).to be_kind_of(Array)
    end
  end

  context "#find_node" do
    it "should return the correct node" do
      expect(subject.find_node(1)).to eq({ id: 1 })
    end
  end

  context "#neighbours_for" do
    it "should return an array of nodes" do
      expect(subject.neighbours_for(1)).to be_kind_of(Array)
    end

    it "should return neighbours" do
      expect(subject.neighbours_for(1)).to eq([{ id: 2 }])
    end
  end

  context "#each_node" do
    it "should iterate over nodes" do
      expect { |b| subject.each_node(&b) }.to yield_control.exactly(nodes.length).times
    end

    it "should yield with node id and node hash" do
      expect { |b| subject.each_node(&b) }.to yield_successive_args([1, {:id=>1}], [2, {:id=>2}], [3, {:id=>3}])
    end
  end

  context "from_dot_file" do
    let (:dot_file) { 'spec/fixtures/graph.dot' }

    it "should raise if it can't find dot file" do
      expect{
        Graphr::Graph.from_dot_file('/does/not/exist')
      }.to raise_error(Graphr::DotFileNotFound, "/does/not/exist can't be found")
    end

    it "should parse dot file and return a Graphr::Graph instance"  do
      expect(Graphr::Graph.from_dot_file(dot_file)).to be_kind_of(Graphr::Graph)
    end

    it "should have the correct number of nodes"  do
      expect(Graphr::Graph.from_dot_file(dot_file).nodes.count).to eq(8)
    end

    it "should have the correct number of edges"  do
      expect(Graphr::Graph.from_dot_file(dot_file).edges.count).to eq(9)
    end
  end
end
