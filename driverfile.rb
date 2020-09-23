# frozen_string_literal: true

require_relative 'main.rb'
arr = Array.new(15) { rand(1..100) }
bst = Tree.new(arr)
bst.pretty_print
p bst.balanced?
p bst.level_order
p bst.inorder
p bst.preorder
p bst.postorder
bst.insert_val(124)
bst.insert_val(216)
p bst.balanced?
bst.pretty_print
bst.rebalance
p bst.balanced?
bst.pretty_print
p bst.level_order
p bst.inorder
p bst.preorder
p bst.postorder
