##
## so_class_spec.rb
## Login : <lta@still>
## Started on  Mon Jun 17 19:16:57 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##  Edited by
##  - Emmanuel Derozin <emmanueldd>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'so_class'

class Point
  def initialize(x = 0,y = 0)
    @x = x
    @y = y
  end

  def x()
    return @x
  end

  def y()
    return @y
  end

  def pos()
      return [@x,@y]
  end

  def x=(value)
    @x = value
  end

  def y=(value)
    @y = value
  end

  def move!(x, y)
    @x = @x + x
    @y = @y + y
  end

  def move_to!(x, y)
    @x = x
    @y = y
  end

  def +(point)
    Point.new(@x + point.x, @y + point.y)
  end

  def magic?()
    if @x == 42 && @y ==42
      return true
    end
    return false
  end

  protected
    def move_to_magic_position!()
      @x = 42
      @y = 42
    end

  def self.random(count, xmin, ymin, xmax, ymax)
    $i= 0
    array = Array.new
    while $i < count
      xPos = rand(xmin..xmax)
      yPos = rand(ymin..ymax)
      array[$i] =  Point.new(xPos, yPos)
      $i+=1
    end
    return array
  end

  def self.random_count()
    return ObjectSpace.each_object(Point).count
  end

end

class ColouredPoint < Point
  def initialize(x =0, y=0, color = 'FFFFFF')
    @color = color
    @x = x
    @y = y
  end
  def new

  end

  def color()
    return @color
  end

  def color=(value)
    @color = value
  end

  def red()
    @color = '11'
  end

  def green()
    @color = '22'
  end

  def blue()
    @color = '33'
  end
end

describe 'So Class:' do
  describe Point do
    describe 'creation' do
      it 'works' do
        point = Point.new(10, 20)

        expect(point.is_a?(Point)).to be_truthy
        expect(point.x).to eq(10)
        expect(point.y).to eq(20)
        expect(point.pos).to eq([10, 20])
      end

      it 'works also without parameters' do
        point = Point.new

        expect(point.is_a?(Point)).to be_truthy
        expect(point.x).to eq(0)
        expect(point.y).to eq(0)
      end
    end

    describe 'operations:' do
      before(:each) do
        @p1 = Point.new(1, 2)
        @p2 = Point.new(3, 4)
      end

      it 'supports assignation' do
        @p1.x = @p1.y = 42

        expect(@p1.x).to eq(42)
        expect(@p1.y).to eq(42)
      end

      it 'supports relative move' do
        @p1.move!(5, 5)
        expect(@p1.pos).to eq([6, 7])
      end
      it 'supports absolute move' do
        @p1.move_to!(5, 5)
        expect(@p1.pos).to eq([5, 5])
      end
      it 'supports addition of 2 points' do
        p3 = @p1 + @p2
        expect(p3.pos).to eq([4, 6])
      end
    end

    describe 'Magic' do
      it 'detects if it is at magic place' do
        expect(Point.new.magic?).to be_falsey
        expect(Point.new(42, 42).magic?).to be_truthy
      end
      it 'has a protected method that moves the point to magic position !' do
        point = Point.new

        expect { point.move_to_magic_position! }.to raise_error(NoMethodError)

        expect(point.magic?).to be_falsey
        point.instance_eval { move_to_magic_position! }
        expect(point.magic?).to be_truthy
      end
    end

    describe 'Random factory' do
      # Point's random Class Methods, takes 5 parameters:
      # - count, xmin, ymin, xmax, ymax
      # it returns count point with random position between [xmin, ymin] and [xmax, ymax]
      it 'creates bunch of random points' do
        points = Point.random(10, 5, 5, 100, 100)

        expect(points.is_a?(Array)).to be_truthy
        expect(points.length).to eq(10)

        points.each do |point|
          expect(point.is_a?(Point)).to be_truthy
          expect(point.x).to be >= 5
          expect(point.y).to be >= 5
          expect(point.x).to be <= 100
          expect(point.y).to be <= 100
        end
      end

      it 'counts the number of random created objects' do
        count = Point.random_count
        Point.random(10, 5, 5, 100, 100)
        expect(Point.random_count).to eq(10 + count)
      end
    end
  end

  describe ColouredPoint do
    it 'is a Point with a color' do
      white_point = ColouredPoint.new

      expect(white_point.is_a?(Point)).to be_truthy
      expect(white_point.is_a?(ColouredPoint)).to be_truthy

      expect(white_point.x).to eq(0)
      expect(white_point.y).to eq(0)
      expect(white_point.color).to eq('FFFFFF')
    end

    it 'can change of colour' do
      white_point = ColouredPoint.new

      white_point.color = 'F1C420'
      expect(white_point.color).to eq('F1C420')
    end

    it 'provides handy accessor for color components' do
      point = ColouredPoint.new(0, 0, '112233')

      expect(point.red).to   eq('11')
      expect(point.green).to eq('22')
      expect(point.blue).to  eq('33')
    end

    it 'supports all Point\'s operations' do
      p1 = Point.new(1, 2)
      p2 = Point.new(3, 4)

      p3 = p1 + p2
      p3.move!(10, 10)
      expect(p3.pos).to eq([14, 16])
    end
  end


end
