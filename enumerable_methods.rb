# frozen_string_literal: true

# rubocop:disable Style/CaseEquality

module Enumerable
  # my_each
  def my_each
    return to_enum unless block_given?

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
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_all?(pattern = nil)
    return to_enum unless block_given?

    arr = self
    if !block_given? && pattern.nil?
      arr.my_each do |i|
        return false unless i
      end
    elsif self.class == Array
      arr.my_each do |i|
        return false unless yield(i)
      end
    elsif self.class == Hash
      arr.my_each do |k, v|
        return false unless yield(k, v)
      end
    else
      arr.my_each do |i|
        return false unless i === pattern
      end
    end
    true
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  # my_any
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_any?(pattern = nil)
    return to_enum unless block_given?

    arr = self
    if !block_given? && pattern.nil?
      arr.my_each do |i|
        return true if i
      end
    elsif self.class == Array
      arr.my_each do |i|
        return true if yield(i)
      end
    elsif self.class == Hash
      arr.my_each do |k, v|
        return true if yield(k, v)
      end
    else
      arr.my_each do |i|
        return true if i === pattern
      end
    end
    false
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  # my_none
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_none?(pattern = nil)
    return to_enum unless block_given?

    arr = self
    if !block_given? && pattern.nil?
      arr.my_each do |i|
        return false if i
      end
    elsif self.class == Array
      arr.my_each do |i|
        return false if yield(i)
      end
    elsif self.class == Hash
      arr.my_each do |k, v|
        return false if yield(k, v)
      end
    else
      arr.my_each do |i|
        return false if i === pattern
      end
    end
    true
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  # rubocop:enable Style/CaseEquality

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
    return to_enum unless block_given?

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
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_inject(*initial)
    result = nil
    if block_given?
      arr = dup.to_a
      result = initial[0].nil? ? arr[0] : initial[0]
      arr.shift if initial[0].nil?
      arr.my_each do |i|
        result = yield(result, i)
      end
    elsif !block_given?
      arr = dup.to_a
      if initial[1].nil?
        sym = initial[0]
        result = arr[0]
        arr[1..-1].my_each do |i|
          result = result.send(sym, i)
        end
      elsif !initial[1].nil?
        sym = initial[1]
        result = initial[0]
        arr.my_each do |i|
          result = result.send(sym, i)
        end
      end
    end
    result
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

def multiply_els(arr)
  arr.my_inject(1) { |x, y| x * y }
end
puts multiply_els([2, 4, 5])
