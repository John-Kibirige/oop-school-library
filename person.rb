class Person
    attr_accessor :name, :age
    attr_reader :id 

    def initialize( age, name = 'Unknown', parent_permission = true)
        @name = name
        @age = age 
        @parent_permission = parent_permission
    end 

    private def is_of_age? 
        return @age > 18
    end  

    def can_use_services?
        return @parent_permission && is_of_age?
    end 
end 
