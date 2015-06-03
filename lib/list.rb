module Slist
  def eval_list(exp, env)
    exp.map { |e| _eval(e, env) }
  end

  def list?(exp)
    exp.is_a? Array
  end

  def _eval exp, env
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

  def lookup_var var, env
    alist = env.find {|alist| alist.key? var }
    raise "Couldn't find value to variables: '#{var}'" if alist.nil?
    alist[var]
  end

  def car list
    list[0]
  end

  def cdr list
    list[1..-1]
  end

  def immediate_val? exp
    num? exp
  end

  def num? exp
    exp.is_a? Numeric
  end
end
