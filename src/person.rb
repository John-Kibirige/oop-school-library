require_relative './nameable.rb'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    @parent_permission || of_age?
  end

  def correct_name
    @name 
  end

  private

  def of_age?
    @age > 18
  end
end
