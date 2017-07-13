##
## metaprog_spec.rb
## Login : <lta@still>
## Started on  Tue Jun 18 11:32:26 2013 Lta Akr
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
require 'advanced'

#
# This last bag of spec contains a few advanced ruby stuff as well as
# some other mid-level stuff which weren't fitting in the previous
# series.
#
describe Advanced do
  it 'is a module' do
    expect(Advanced.class == Module).to be_truthy
    # is almost the same as
    expect(Advanced.is_a?(Module)).to be_truthy
  end
  describe 'with methods' do
    # Advanced.class_as_string(klass) return the name of the class of
    # the object given in parameter
    specify '#class_as_string' do
      expect(Advanced.class_as_string(Array)).to eq('Array')
      expect(Advanced.class_as_string(Hash)).to eq('Hash')
      expect(Advanced.class_as_string(String)).to eq('String')
    end

    # Hint: Google: 'ruby const_get', 'ruby Kernel'
    specify '#string_as_class' do
      expect(Advanced.string_as_class('String')).to eq(String)
      expect(Advanced.string_as_class('String').new.is_a?(String)).to be_truthy

      expect(Advanced.string_as_class('Array')).to eq(Array)
      array = Advanced.string_as_class('Array').new
      array << 1 << 2 << 3
      expect(array.is_a?(Array)).to be_truthy
      expect(array).to eq([1, 2, 3])

      expect(Advanced.string_as_class('Point')).to eq(Point)
      point = Advanced.string_as_class('Point').new
      expect(point.is_a?(Point)).to be_truthy
      expect(point.pos).to eq([0, 0])
    end

    specify '#respond_to_each?' do
      expect(Advanced.respond_to_each?(Hash.new)).to be_truthy
      expect(Advanced.respond_to_each?(Array.new)).to be_truthy
      expect(Advanced.respond_to_each?({})).to be_truthy # same as first one
      expect(Advanced.respond_to_each?([])).to be_truthy # same as second one

      expect(Advanced.respond_to_each?(0..10)).to be_truthy
    end

    # Hint: google 'ruby method_missing', 'Symbol#to_s / String#to_sym'
    specify '#respond_to_something?' do
      expect(Advanced.respond_to_uniq?(Array.new)).to be_truthy
      expect(Advanced.respond_to_unexistent?(Array.new)).to be_falsey
      expect(Advanced.respond_to_keys?(Hash.new)).to be_truthy
      expect(Advanced.respond_to_unexistent?(Hash.new)).to be_falsey
      expect { Advanced.unexistent?(Hash.new) }
        .to raise_error
      expect { Advanced.respond_to_keys(Hash.new) }
        .to raise_error
    end

    # Hint: This is a one-liner
    specify '#calculette' do
      expect(Advanced.calculette('1 + 1')).to eq(2)
      expect(Advanced.calculette('(5 * 5 - 2) / 0.5')).to eq(46.0)
      expect(Advanced.calculette('2 ** 2')).to eq(4)
    end
  end
end
