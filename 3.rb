require './cap1/eval'
require './cap2/env'

val = [:letrec,
  [[:fact,
    [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, :fact, [:-, :n, 1]]]]]], [:fact, 3]]

three_two_ok = [:let,
  [[:fact,
    [:lambda,
      [:n],
      [:if,
        [:<, :n, 1],
        1,
        [:*, :n, [:fact, [:-, :n, 1]]]
      ]
    ]
  ]],
  [:fact, 0]]

three_two_ng = [:let,
 [[:fact,
   [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, [:fact, [:-, :n, 1]]]]]]],
 [:fact, 1]]
