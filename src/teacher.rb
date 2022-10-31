require_relative './person'
class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization, age)
    super(age)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

teacher = Teacher.new('Physics', 45)
puts teacher.age
