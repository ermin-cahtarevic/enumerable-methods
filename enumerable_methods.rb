# frozen_string_literal: true

module Enumerable 

  #my_each
  def my_each
    return self.to_enum unless block_given?
    if self.class == Array
      i = 0
      while i < self.length
        yield(self[i])
        i += 1
      end
    elsif self.class == Hash
      keys = self.keys
      keys.length.times do |i|
        key = keys[i]
        value = self[key]
        yield(key, value)
      end
    end
    self
  end

  #my_each_with_index

  def my_each_with_index
    return self.to_enum unless block_given?
    if self.class == Array
      i = 0
      while i < self.length
        yield(self[i], i)
        i += 1
      end
    elsif self.class == Hash
      keys = self.keys
      keys.length.times do |i|
        key = keys[i]
        value = self[key]
        key_value = [key, value]
        yield(key_value, i)
      end
    end
    self
  end

  #my_select

  def my_select
    return self.to_enum unless block_given?
    new_arr = []
    i = 0
    while i < self.size
      if yield(self[i])
        new_arr << self[i]
      end
      i += 1
    end
    new_arr
  end

  #my_all

  def my_all?
    if !block_given?
      return self.my_all? { |obj| obj }
    end
    if self.class == Array
      length = self.size - 1
      self.length.times do |i|
        return false unless yield(self[i])
      end
    elsif self.class == Hash
      keys = self.keys
      self.length.times do |i|
        return false unless yield(keys[i], self[keys[i]])
      end
    end
    true
  end

  #my_any

  def my_any?
    if !block_given?
      return self.my_any? { |obj| obj }
    end
    if self.class == Array
      length = self.size
      self.length.times do |i|
        return true if yield(self[i])
      end
    elsif self.class == Hash
      keys = self.keys
      keys.length.times do |i|
        return true if yield(keys[i], self[keys[i]])
      end
    end
    false
  end

  #my_none

  def my_none?
    if !block_given?
      return self.my_none? { |obj| obj }
    end
    if self.class == Array
      length = self.size
      self.length.times do |i|
        return false if yield(self[i])
      end
    elsif self.class == Hash
      keys = self.keys
      keys.length.times do |i|
        return false if yield(keys[i], self[keys[i]])
      end
    end
    true
  end

  # my_count

  def my_count(arg = nil)
    return length unless block_given? || !arg.nil?

    counter = 0
    if !arg.nil?
      self.my_each do |i|
        counter += 1 if i == arg
      end
    elsif self.class == Array
      self.my_each do |i|
        counter += 1 if yield(i)
      end
    elsif self.class == Hash
      keys = self.keys
      self.my_each do |i|
        counter += 1 if yield(keys[i], self[keys[i]])
      end
    end
    counter
  end


end

