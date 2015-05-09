
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
  new_exp = [[:lambda, parameters, body]] + args
  _eval(new_exp, env)
end

def let_to_parameters_args_body exp
  [exp[1].map{|e| e[0]}, exp[1].map{|e| e[1]}, exp[2]]
end

def let? exp
  exp[0] == :let
end

def eval_lambda exp, env
  make_closure exp, env
end

def make_closure exp, env
  parameters, body = exp[1], exp[2]
  [:closure, parameters, body, env]
end

def lambda_apply closure, args
  parameters, body, env = closure_parameters_body_env closure
  new_env = extend_env parameters, args, env
  _eval body, new_env
end

def closure_parameters_body_env closure
  [closure[1], closure[2], closure[3]]
end

