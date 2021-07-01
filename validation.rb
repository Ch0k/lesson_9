module Validation
# frozen_string_literal: true

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :var_array
    def validate(var, type, *params)
      @var_array ||= []
      @var_array << { var_name: var, type_name: type, params: params}
    end

  end

  module InstanceMethods

  def validate!
    validate_presence
    true
  rescue StandardError
    false
    #Содержит инстанс-метод validate!, который запускает все проверки (валидации), 
    #указанные в классе через метод класса validate. В случае ошибки валидации 
    #выбрасывает исключение с сообщением о том, какая именно валидация не прошла
    end
    
  def valid?
    validate_presence
    true
      #Содержит инстанс-метод valid? который возвращает true, если все проверки 
      #валидации прошли успешно и false, если есть ошибки валидации.
  end

  def validate_presence
    @fff = self.class.var_array
    @fff.each do |var|
      if var[:type_name] == :presence
        self.presence(var[:var_name])
      elsif var[:type_name] == :format
        self.format(var[:var_name], var[:params])
      else var[:type_name] == :type
        self.type(var[:var_name], var[:params])
      end
    end
  end

  def presence(name)
    puts "#{name}"
    #raise 'Number should be at least 6 symbols' if name.nil?
  end

  def type(name, params)
    raise 'Class has invalid type' if name.class != params[0]
  end

  def format(name, params)
    raise 'Number has invalid format' if name !~ params[0]
    #raise 'Number has invalid format' if name !~ /#{Regexp.quote([A-Za-z])}/
  end

  end
end



class Test
  include Validation
  validate :name, :presence
  #validate :namesss, :format, /[a-z]{6,}/
 # validate :number, :format, /^[\d\w]{3}-?[\d\w]{2}$/
  #validate :name, :type, Symbol
  #validate :format, :number, /^[\d\w]{3}-?[\d\w]{2}$/

  def initialize(name)
  end
  
 # validate :name, :format
 # validate :names, :type
end