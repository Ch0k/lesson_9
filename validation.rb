# frozen_string_literal: true

# module for validation
module Validation
  # frozen_string_literal: true

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module for craete variable for create methods
  module ClassMethods
    attr_accessor :var_array

    def validate(var, type, *params)
      @var_array ||= []
      @var_array << { var_name: var, type_name: type, params: params }
    end
  end

  # module for validation instances methods
  module InstanceMethods
    def validate!
      validate_presence
      true
    rescue StandardError
      false
    end

    def valid?
      validate_presence
      true
    end

    def validate_presence
      @fff = self.class.var_array
      @fff.each { |var| send(var[:type_name], (var[:var_name]), var[:params]) }
    end

    def presence(name, _)
      raise 'Number should be at least 6 symbols' if name.nil?
    end

    def type(name, params)
      raise 'Class has invalid type' if name.class != params[0]
    end

    def format(name, params)
      raise 'Number has invalid format' if name !~ params[0]
    end
  end
end

# Class for Test
class Test
  include Validation
  # validate :name, :presence
  # validate :namesss, :format, /[a-z]{6,}/
  # validate :number, :format, /^[\d\w]{3}-?[\d\w]{2}$/
  validate :name, :type, Symbol
  # validate :format, :number, /^[\d\w]{3}-?[\d\w]{2}$/

  def initialize(name); end

  # validate :name, :format
  # validate :names, :type
end
