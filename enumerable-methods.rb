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


end