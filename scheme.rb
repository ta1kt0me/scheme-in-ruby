require './cap1/eval.rb'
require './cap2/env.rb'

exp = [:let, [[:x, 3]],
  [:let, [[:fun, [:lambda, [:y], [:+, :x, :y]]]],
    [:+, [:fun, 1], [:fun, 2]]]]
puts _eval(exp, $global_env)

