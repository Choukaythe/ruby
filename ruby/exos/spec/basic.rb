##
## basic_spec.rb
## Login : <lta@still>
## Started on  Mon Jun 17 17:38:17 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##  Edited by
##  - Emmanuel Derozin <emmanueldd>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'
require 'basic'

describe 'Basics:' do
  it 'Define constants and globals' do
    expect(defined?(CONSTANT)).to be_falsey
    expect(defined?(CONSTANT2)).to be_falsey

    expect(defined?($my_string)).to be_falsey
    expect($my_string.is_a?(String)).to be_falsey

    expect(defined?($my_symbol)).to be_falsey
    expect($my_symbol.is_a?(Symbol)).to be_falsey

    expect(defined?($my_array)).to be_falsey
    expect($my_array.is_a?(Array)).to be_falsey

    expect(defined?($my_float)).to be_falsey
    expect($my_float.is_a?(Float)).to be_falsey

    expect(defined?($my_nil)).to be_falsey
    expect($my_nil).to be_nil

    expect(defined?($my_boolean)).to be_falsey
    expect($my_boolean == true || $my_boolean == false)
      .to be_falsey
  end

  it 'say Hello!' do
     expect(hello()).to eq("Hello, Ruby World!")
   end

   def hello()
     return "Hello, Ruby World!"
   end

  # Define a method called 'nothing' which takes 3 parameters with
  # default values (we don't care about the value of the defaults)
  # The method does nothing and return nil
  it 'supports default parameters value' do
    expect(nothing()).to be_nil
    expect(nothing(1)).to be_nil
    expect(nothing(1, 2)).to be_nil
    expect(nothing(1, 2, 3)).to be_nil
    expect { nothing(1, 2, 3, 4) }
      .to raise_error(ArgumentError)
  end

  def nothing(var = nil, var2 = nil, var3 = nil)
    return nil
  end

  it 'computes Fibonacci sequence' do
    expect(fibonacci(1)).to eq(1)
    expect(fibonacci(2)).to eq(1)
    expect(fibonacci(3)).to eq(fibonacci(1) + fibonacci(2))
    expect(fibonacci(4)).to eq(fibonacci(2) + fibonacci(3))
    expect(fibonacci(12)).to eq(144)
    expect(fibonacci(18)).to eq(2584)
    expect(fibonacci(23)).to eq(28657)
  end

  def fibonacci( n )
      return  n  if n <= 1
      fibonacci( n - 1 ) + fibonacci( n - 2 )
  end

  # Hint: 'def who_is_bigger(a, b, c)'
  it 'tells me the biggest' do
    expect(who_is_bigger(84, 42, nil)).to eq("nil detected")
    expect(who_is_bigger(nil, 42, 21)).to eq("nil detected")
    expect(who_is_bigger(84, 42, 21)).to eq("a is bigger")
    expect(who_is_bigger(42, 84, 21)).to eq("b is bigger")
    expect(who_is_bigger(42, 21, 84)).to eq("c is bigger")
  end

  def who_is_bigger(a, b, c)
    if a == nil || b == nil || c == nil
      return "nil detected"
    end
    result = [a,b,c].max
    if result == a
      return "a is bigger"
    end
    if result == b
      return "b is bigger"
    end
    if result == c
      return "c is bigger"
    end
  end

  # Reverse, upcase then removes all L, T and A.
  # Hint: google ruby string
  it 'does crazy stuff on strings' do
    expect(reverse_upcase_noLTA("Tries this at Home, Kids"))
      .to eq("SDIK ,EMOH  SIH SEIR")
    expect(reverse_upcase_noLTA("Ponies loves carrots"))
      .to eq("SORRC SEVO SEINOP")
    expect(reverse_upcase_noLTA("qwertyuiopasdfghjkl;zxcvbn"))
      .to eq("NBVCXZ;KJHGFDSPOIUYREWQ")
  end

  def reverse_upcase_noLTA(string)
    string = string.reverse
    string = string.upcase
    string = string.tr('L','')
    string = string.tr('T','')
    string = string.tr('A','')
    return string
  end

  # array_42 takes an array as parameter and returns:
  # - true if there's a 42 in the array items
  # - false otherwise
  # Hint: Should be 2 lines (and can be one :)
  # Hint: google ruby array each
  it 'finds 42' do
    expect(array_42([1, 2, 3, 4, 5, 6, 7 , 8, 9, 10])).to be_falsey
    expect(array_42([1, 2, 3, 4, 5, 6, 7 , 8, 9, 42, 21, 10.5])).to be_truthy
  end

  def array_42(array)
    array.include?(42) ? true : false
  end

  # The magic_array function takes an array of number or an array of
  # array of number as parameter and return the same array :
  # - flattened (i.e. no more arrays in array)
  # - reversed
  # - with each number multiplicated by 2
  # - with each multiple of 3 removed
  # - with each number duplicate removed (any number should appear only once)
  # - sorted
  # Hint: You can do this in one line than less than 55 chars
  it 'does crazy stuff on Arrays' do
    expect(magic_array([1, 2, 3, 4, 5, 6]))
      .to eq([2, 4, 8, 10])
    expect(magic_array([1, [2, 3], 4, 5, 6, 23, 31, [1, 2, 3]]))
      .to eq([2, 4, 8, 10, 46, 62])
    expect(magic_array([[32, 54], [48, 12], [21, [1, 2, [3]]], 7, 8]))
      .to eq([2, 4, 14, 16, 64])
  end

  def magic_array(array)
    return array.flatten.reverse.collect{|n| n * 2}.reject {|e| e%3 == 0}.uniq.sort
  end
end
