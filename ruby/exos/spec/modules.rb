##
## modules_spec.rb
## Login : <lta@still>
## Started on  Tue Jun 18 01:03:43 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##  Edited by
##  - Emmanuel Derozin <emmanueldd>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'modules'

class Geometry
  def new
  end
end


describe Geometry do
  it 'has a VERSION constant' do
    expect(defined?(Geometry::VERSION)).to be_truthy
    expect(Geometry::VERSION).to eq('0.0.1')
  end

  # Geometry.distance(p1, p2) return the distance between p1 and p2
  it 'has a distance module method' do
    p1 = Point.new
    p2 = Point.new(10, 0)
    p3 = Point.new(10, 10)

    expect(Geometry.distance(p1, p2)).to eq(10)
    expect(Geometry.distance(p1, p3)).to eq(Math.sqrt(200))
  end

  describe Geometry::Shape do
    before(:each) do
      @p1 = Point.new
      @p2 = Point.new(5, 5)
      @p3 = Point.new(0, 10)
    end

    it 'can be created' do
      shape = Geometry::Shape.new()

      expect(shape.is_a?(Geometry::Shape)).to be_truthy
      expect(shape.points.empty?).to be_truthy
    end

    it 'can be created with a list of points' do
      shape = Geometry::Shape.new [@p1, @p2, @p3]

      expect(shape.is_a?(Geometry::Shape)).to be_truthy
      expect(shape.points.is_a?(Array)).to be_truthy
      expect(shape.points.length).to eq(3)
      expect(shape.points.first).to eq(@p1)
      expect(shape.points.last).to eq(@p3)
    end

    it 'can grow and shrink' do
      shape = Geometry::Shape.new
      expect(shape.points.length).to eq(0)

      shape.add_point(@p1)
      shape.add_point(@p2)
      shape.add_point(@p3)
      expect(shape.points).to eq([@p1, @p2, @p3])

      shape.remove_point
      expect(shape.points).to eq([@p1, @p2])
    end
  end

  describe 'Detectors' do
    example 'There are 2 detectors' do
      expect(Geometry::LineDetector.is_a?(Module)).to be_truthy
      expect(Geometry::TriangleDetector.is_a?(Module)).to be_truthy
      #Geometry::RectangleDetector.is_a?(Module).should be_true
    end

    it 'The detectors are _included_ in Shape' do
      expect(Geometry::Shape.include?(Geometry::LineDetector)).to be_truthy
      expect(Geometry::Shape.include?(Geometry::TriangleDetector)).to be_truthy
      #Geometry::Shape.include?(Geometry::RectangleDetector).should be_true
    end

    describe Geometry::LineDetector do
      it 'has a line? method' do
        expect(Geometry::LineDetector.instance_methods.include?(:line?)).to be_truthy
      end

      it 'detects if the shape is a line' do
        p1 = Point.new
        p2 = Point.new(1, 1)
        shape = Geometry::Shape.new([p1, p2])
        expect(shape.line?).to be_truthy
      end
    end

    describe Geometry::TriangleDetector do
      it 'has a triangle? method' do
        expect(Geometry::TriangleDetector.instance_methods.include?(:triangle?)).to be_truthy
      end

      it 'detects if the shape is a triangle' do
        p1 = Point.new
        p2 = Point.new(0.5, 1)
        p3 = Point.new(1, 0)
        shape = Geometry::Shape.new([p1, p2, p3])
        expect(shape.triangle?).to be_truthy
      end
    end
  end
end
