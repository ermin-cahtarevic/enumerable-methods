require './enumerable_methods'

describe Enumerable do
  let (:arr) { [1, 2, 3, 4] }

  describe '#my_each' do
    it 'returns enum if block not given' do
      expect(arr.my_each).to be_an Enumerator
    end

    it 'returns self if block given' do
      expect(arr.my_each { |x| x + 1 }).to eql(arr)
    end
  end

  describe '#my_each_with_index' do
    it 'returns enum if block not given' do
      expect(arr.my_each_with_index).to be_an Enumerator
    end

    it 'returns self if block given' do
      expect(arr.my_each_with_index { |x, i| "Number #{x}, index #{i}" }).to eql(arr)
    end
  end

  describe '#my_select' do
    it 'returns enum if block not given' do
      expect(arr.my_select).to be_an Enumerator
    end

    it 'returns elements that yield true if block is given' do
      expect(arr.my_select { |x| x > 2 }).to eql([3, 4])
    end
  end
end