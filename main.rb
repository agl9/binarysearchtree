# frozen_string_literal: true

# class creating the node
class Node
  attr_accessor :data, :left, :right
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# class creating the binary search tree
class Tree
  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr, 0, @arr.length - 1)
  end

  def build_tree(arr, first, last)
    return nil if first > last

    mid = (first + last) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr, first, mid - 1)
    root.right = build_tree(arr, mid + 1, last)
    root
  end

  def insert_val(val, current_root = @root)
    if current_root.nil?
      new_node = Node.new(val)
      return new_node
    end

    current_root.left = insert_val(val, current_root.left) if val < current_root.data

    current_root.right = insert_val(val, current_root.right) if val > current_root.data

    current_root
  end

  def delete_val(val, current_root = @root)
    return nil if current_root.nil?

    current_root.left = delete_val(val, current_root.left) if val < current_root.data

    current_root.right = delete_val(val, current_root.right) if val > current_root.data

    return delete_node(current_root) if val == current_root.data

    current_root
  end

  def delete_node(node)
    return node.left if node.right.nil?

    return node.right if node.left.nil?

    next_val = min_right(node.right)
    delete_val(next_val)
    node.data = next_val
    node
  end

  def min_right(node)
    return node.data if node.left.nil?

    min_right(node.left)
  end

  def find(val, current_root = @root)
    return nil if current_root.nil?

    return current_root if current_root.data == val

    return find(val, current_root.left) if current_root.data > val
    return find(val, current_root.right) if current_root.data < val
  end

  def level_order(root = @root, arr = [], queue = [])
    arr << root.data
    queue << root.left if root.left
    queue << root.right if root.right
    level_order(queue.shift, arr, queue) unless queue.empty?
    arr
  end

  def level_iteration(queue = [@root], arr = [])
    until queue.empty?
      queue << queue[0].left if queue[0].left
      queue << queue[0].right if queue[0].right
      arr << queue.shift.data
    end
    arr
  end

  def inorder(root = @root, arr = [])
    return if root.nil?

    inorder(root.left, arr)
    arr << root.data
    inorder(root.right, arr)
    arr
  end

  def preorder(root = @root, arr = [])
    return if root.nil?

    arr << root.data
    preorder(root.left, arr)
    preorder(root.right, arr)
    arr
  end

  def postorder(root = @root, arr = [])
    return if root.nil?

    postorder(root.left, arr)
    postorder(root.right, arr)
    arr << root.data
    arr
  end

  def height(node)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    left_height >= right_height ? left_height + 1 : right_height + 1
  end

  def depth(node, root = @root, level = 0)
    return level if node == root
    return -1 if root.nil?

    left_depth = depth(node, root.left, level + 1)
    right_depth = depth(node, root.right, level + 1)
    left_depth >= right_depth ? left_depth : right_depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    difference = (height(node.left) - height(node.right)).abs
    return true if difference <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    @root = build_tree(inorder, 0, inorder.length - 1) unless balanced?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
