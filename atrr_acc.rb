# frozen_string_literal: true

# Module attribute accessor
module Attr
  def attr_accessor(*names)
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
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Type not true' if value.class != type

      instance_variable_set(var_name, value)
    end
  end
end

class Tran
  extend Attr

  attr_accessor :ttt, :aaa

  strong_attr_accessor(:vvv, Integer)
  strong_attr_accessor(:sss, String)
end
