# frozen_string_literal: true

# rubocop:disable Style/CaseEquality

module Enumerable
  # my_each
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
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
  def my_all?(pattern = nil)
    if pattern
      my_each do |i|
        return false unless pattern === i
      end
    elsif block_given?
      my_each do |i|
        return false unless yield(i)
      end
    else
      my_each do |i|
        return false unless i
      end
    end

    true
  end

  # my_any
  def my_any?(pattern = nil)
    if pattern
      my_each do |i|
        return true if pattern === i
      end
    elsif block_given?
      my_each do |i|
        return true if yield(i)
      end
    else
      my_each do |i|
        return true if i
      end
    end

    false
  end

  # my_none
  def my_none?(pattern = nil, &block)
    !my_any?(pattern, &block)
  end
  # rubocop:enable Style/CaseEquality

  # my_count
  def my_count(arg = nil)
    counter = 0
    if !arg.nil?
      my_each do |i|
        counter += 1 if i == arg
      end
    elsif block_given?
      my_each do |i|
        counter += 1 if yield(i)
      end
    else
      counter = length
    end
    counter
  end

  # my_map
  def my_map(param = nil)
    i = 0
    arr = []
    while i < size
      if param
        arr << param.call(self[i])
      elsif block_given?
        arr << yield(self[i])
      else
        return to_enum
      end
      i += 1
    end
    arr
  end

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
