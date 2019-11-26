# frozen_string_literal: true

require './enumerable_methods'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }

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

  describe '#my_all' do
    context 'when no argument or block is given' do
      it 'returns true if all of the elements of the collection are not nil' do
        expect(arr.my_all?).to be true
      end

      it 'returns false if any of the elements of the collection are false or nil' do
        expect([1, nil, 3, 4].my_all?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if all of the collection are a member of the class' do
        expect(arr.my_all?(Integer)).to be true
      end

      it 'returns false if any element of the collection is not a member of the class' do
        expect([1, 2, 3, 'potato'].my_all?(Integer)).to be false
      end
    end

    context 'when a RegExp is passed as an argument' do
      it 'returns true if all of the collection matches the Regex' do
        expect(%w[hello hi aloha].my_all?(/h/)).to be true
      end

      it 'returns false if any element of the collection does not matche the Regex' do
        expect(%w[hello hi aloha potato].my_all?(/h/)).to be false
      end
    end

    context 'when a block is given' do
      it 'returns true if all of the elements yield true' do
        expect(arr.my_all? { |i| i > 0 }).to be true
      end

      it 'returns false if any of the elements yield false' do
        expect(arr.my_all? { |i| i > 1 }).to be false
      end
    end
  end

  describe '#my_any?' do
    context 'when no argument or block is given' do
      it 'returns true if any of the elements of the collection is not false or nil' do
        expect([nil, nil, 3, 4].my_any?).to be true
      end

      it 'returns false if all of the elements of the collection are false or nil' do
        expect([nil, nil, nil].my_any?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if any element of the collection is a member of the class' do
        expect([1, 2, 3, 'potato'].my_any?(String)).to be true
      end

      it 'returns false if no element of the collection is a member of the class' do
        expect(arr.my_all?(String)).to be false
      end
    end

    context 'when a RegExp is passed as an argument' do
      it 'returns true if any element of the collection matches the Regex' do
        expect(%w[hello hi aloha potato].my_any?(/ato/)).to be true
      end

      it 'returns false if no element of the collection matches the Regex' do
        expect(%w[hello hi aloha potato].my_any?(/xyz/)).to be false
      end
    end

    context 'when a block is given' do
      it 'returns true if any of the elements yield true' do
        expect(arr.my_any? { |i| i > 1 }).to be true
      end

      it 'returns false if none of the elements yield true' do
        expect(arr.my_all? { |i| i > 10 }).to be false
      end
    end
  end

  describe '#my_none?' do
    context 'when no argument or block is given' do
      it 'returns true if all of the elements of the collection are false or nil' do
        expect([nil, nil, false, false].my_none?).to be true
      end

      it 'returns false if any of the elements of the collection are not false or nil' do
        expect([nil, 'something', nil].my_none?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if no element of the collection is a member of the class' do
        expect([1, 2, 3, 'potato'].my_none?(Hash)).to be true
      end

      it 'returns false if any element of the collection is a member of the class' do
        expect([1, 2, 3, 'potato'].my_none?(String)).to be false
      end
    end

    context 'when a RegExp is passed as an argument' do
      it 'returns true if no element of the collection matches the Regex' do
        expect(%w[hello hi aloha potato].my_none?(/something/)).to be true
      end

      it 'returns false if any element of the collection matches the Regex' do
        expect(%w[hello hi aloha potato].my_none?(/h/)).to be false
      end
    end

    context 'when a block is given' do
      it 'returns true if none of the elements yield true' do
        expect(arr.my_none? { |i| i > 10 }).to be true
      end

      it 'returns false if any of the elements yield true' do
        expect(arr.my_none? { |i| i > 1 }).to be false
      end
    end
  end
end
