require './cap1/eval.rb'
require './cap2/env.rb'

puts car [1,2,3]

[:let, [[:x, 2]],
 [:let, [[:fun, [:lambda, [], :x]]],
  [:let, [[:x,1]],
    [:fun]]]]
