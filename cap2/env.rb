
def lookup_var var, env
  alist = env.find {|alist| alist.key? var }
  raise "Couldn't find value to variables: '#{var}'" if alist.nil?
  alist[var]
end

def extend_env parameters, args, env
  alist = parameters.zip args
  [alist.to_h] + env
end
