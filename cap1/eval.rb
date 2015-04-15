
def _eval exp
  if not list?(exp)
    if immediate_val? exp
      exp
    else
      lookup_primitive_fun exp
    end
  else
    fun = _eval(car(exp))
    args = eval_list(cdr(exp))
    apply fun, args
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
