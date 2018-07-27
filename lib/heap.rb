class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
  end

  def extract
    @store.length - 1
    @store[0], @store[-1] = @store[-1], @store[0]

    element = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    element
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1)
  end

  public
  def self.child_indices(len, parent_index)
    left = (2 * parent_index) + 1
    right = (2 * parent_index) + 2
    children = []
    children.push(left) if left < len
    children.push(right) if right < len
    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    child_index.even? ? (child_index / 2) - 1 : child_index / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    array.each_index do |i|
      child = BinaryMinHeap.child_indices(len, i)
      next if child.any? { |e| e.nil? } || child.empty?
      left, right = child

      #swap with smaller child 
      if !right.nil?
        left, right = right, left if (prc.call(array[left], array[right]) == 1)
      end
      if prc.call(array[i], array[left]) == 1
        array[i], array[left] = array[left], array[i]
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    (len-1).downto(1) do |i|
      parent = BinaryMinHeap.parent_index(i)
      if prc.call(array[i], array[parent]) == -1
        array[i], array[parent] = array[parent], array[i]
      end
    end
    array
  end
end
