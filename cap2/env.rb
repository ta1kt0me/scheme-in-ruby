
def lookup_var var, env
  alist = env.find {|alist| alist.key? var }
  raise "Couldn't find value to variables: '#{var}'" if alist.nil?
  alist[var]
end

def extend_env parameters, args, env
  alist = parameters.zip args
  [alist.to_h] + env
end

def eval_let exp, env
  parameters, args, body = let_to_parameters_args_body exp
  new_exp = [[:lambda, paramters, body]] + args
  _eval(new_exp, env)
end

def let_to_parameters_args_body exp
  [exp[1].map{|e| e[0]}, exp[1].map{|e| e[1]}, exp[2]]
end

def let? exp
  exp[0] == :let
end
