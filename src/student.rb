require_relative './person.rb'

class Student < Person
    attr_accessor :classroom
    def initialize(age, classroom)
        super (age)
        @classroom = classroom
    end 

    def play_hooky 
        "¯\(ツ)/¯"
    end 
end 

