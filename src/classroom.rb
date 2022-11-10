class Classroom 
    attr_accessor :label
    atrr_reader :students

    def initialize 
        @label = label 
        @students = []
    end

    def add_student(student)
        @students.push(student) unless @students.include?(student)
        student.classroom = self
    end
end