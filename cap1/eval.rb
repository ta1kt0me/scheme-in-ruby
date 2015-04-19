
def _eval exp
  if not list?(exp)
    if immediate_val? exp
      exp
    else
      lookup_var exp, env
    end
  else
    if special_form? exp
      eval_special_form exp, env
    else
      fun = _eval(car(exp), env)
      args = eval_list(cdr(exp), env)
      apply fun, args
    end
  end
end

def special_form? exp
  lambda?(exp) or let?(exp)
end

def lambda? exp
  exp[0] == :lambda
end

def eval_special_form exp, env
  if lambda? exp
    eval_lambda exp, env
  elsif let? exp
    eval_let exp, env
  end
end

def list? exp
  exp.is_a? Array
end

def lookup_primitive_fun exp
  $primitive_fun_env[exp]
end

$primitive_fun_env = {
  :+ => [:prim, lambda{|x, y| x + y}],
  :- => [:prim, lambda{|x, y| x - y}],
  :* => [:prim, lambda{|x, y| x * y}]
}

$global_env = [$primitive_fun_env]

def car list
  list[0]
end

def cdr list
  list[1..-1]
end

def eval_list exp, env
  exp.map { |e| _eval e, env }
end


def immediate_val? exp
  num? exp
end

def num? exp
  exp.is_a? Numeric
end

def apply fun, args
  if primitive_fun? fun
    apply_primitive_fun fun, args
  else
    lambda_apply fun, args
  end
end

def primitive_fun? exp
  exp[0] == :prim
end

def apply_primitive_fun fun, args
  fun_val = fun[1]
  fun_val.call *args
end
