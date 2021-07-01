module Attr
  
  def my_attr_accessor(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history << value
      end 
    define_method("#{name}_history") { history }
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    type = type
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise "Type not true" if value.class != type
      instance_variable_set(var_name, value)
    end
  end
end
end

class Tran
  extend Attr

  my_attr_accessor :ttt, :aaa
  strong_attr_accessor(:vvv, Integer)
  strong_attr_accessor(:sss, String)
end