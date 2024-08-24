# frozen_string_literal: true

RSpec.describe Spiaggia::Geometry::Rectangle do
  let(:one) { described_class.new x1: 0, y1: 1, x2: 3, y2: 5 }

  let(:two) { described_class.new x1: 1, y1: 2, x2: 5, y2: 6 }

  it "implements #height" do
    expect(one.height).to eq 4
  end

  it "implements #width" do
    expect(one.width).to eq 3
  end

  describe "#&" do
    it "finds the intersection of two rectangles" do
      expect(one & two).to have_attributes x1: 1, y1: 2, x2: 3, y2: 5
    end
  end

  describe "#|" do
    it "finds the union of two rectangles" do
      expect(one | two).to have_attributes x1: 0, y1: 1, x2: 5, y2: 6
    end
  end
end
