require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
  end
  until heap.store.length == k
    heap.extract
  end
  heap.store
end
