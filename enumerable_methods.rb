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
    return self.to_enum if !block_given?
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
    return self.to_enum if !block_given?
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

end

