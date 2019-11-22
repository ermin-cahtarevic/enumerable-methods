# frozen_string_literal: true

module Enumerable
  # my_each
  def my_each
    return .to_enum unless block_given?
    if self.class == Array
      i = 0
      while i < length
        yield(self[i])
        i += 1
      end
    elsif self.class == Hash
      keys = self.keys
      keys.length.times do |item|
        key = keys[item]
        value = self[key]
        yield(key, value)
      end
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    if self.class == Array
      i = 0
      while i < length
        yield(self[i], i)
        i += 1
      end
    elsif self.class == Hash
      keys = self.keys
      keys.length.times do |item|
        key = keys[item]
        value = self[key]
        key_value = [key, value]
        yield(key_value, item)
      end
    end
    self
  end

  # my_select
  def my_select
    return to_enum unless block_given?

    new_arr = []
    i = 0
    while i < size
      new_arr << self[i] if yield(self[i])
      i += 1
    end
    new_arr
  end

  # my_all
  def my_all?
    return my_all? { |obj| obj } unless block_given?

    if self.class == Array
      length.times do |i|
        return false unless yield(self[i])
      end
    elsif self.class == Hash
      keys = self.keys
      length.times do |i|
        return false unless yield(keys[i], self[keys[i]])
      end
    end
    true
  end

  # my_any
  def my_any?
    return my_any? { |obj| obj } unless block_given?

    if self.class == Array
      length.times do |i|
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

  # my_none
  def my_none?
    return my_none? { |obj| obj } unless block_given?

    if self.class == Array
      length.times do |i|
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
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_count(arg = nil)
    return length unless block_given? || !arg.nil?

    counter = 0
    if !arg.nil?
      my_each do |i|
        counter += 1 if i == arg
      end
    elsif self.class == Array
      my_each do |i|
        counter += 1 if yield(i)
      end
    elsif self.class == Hash
      keys = self.keys
      my_each do |i|
        counter += 1 if yield(keys[i], self[keys[i]])
      end
    end
    counter
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  # my_map
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_map(param = nil)
    return my_map { |obj| obj } unless block_given?

    i = 0
    arr = []
    while i < size
      if block_given? && param.nil?
        arr << yield(self[i])
      elsif block_given? && param
        arr << param.call(self[i])
      end
      i += 1
    end
    arr
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  # my_inject
  def my_inject(*initial)
    result = nil
    arr = to_a
    result = initial[0].nil? ? arr[0] : initial[0]
    arr.shift if initial[0].nil?
    arr.length.times do |i|
      result = yield(result, arr[i])
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |x, y| x * y }
end
puts multiply_els([2, 4, 5])
