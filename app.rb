require_relative './src/book.rb'
require_relative './src/student.rb'
require_relative './src/teacher.rb'
require_relative './src/rental.rb'

class App 
    attr_reader :all_books, :all_people, :all_rentals

    def initialize 
        @all_books = []
        @all_people = {students: [], teachers: []}
        @all_rentals_by_id = []
    end
    
    def create_student
        print "Age: "
        age = gets.chomp 
        print "Classroom: "
        classroom = gets.chomp 
        print "Name: "
        name = gets.chomp 
        print "Parents permision Y/N: "
        permission = gets.chomp
        
        student = Student.new(age.to_i, classroom, name, permission.upcase == 'Y' ? 'true' : 'false')
        @all_people[:students].push(student)
        puts "Student created successfully"
    end 

    def create_teacher
        print "Name: "
        name = gets.chomp 
        print "Specialization: "
        specialization = gets.chomp 
        print "Age: "
        age = gets.chomp 

        teacher = Teacher.new(specialization, age, name)        
        @all_people[:teachers].push(teacher)
        puts "Teacher created successfully"
    end

    def create_book 
        print "Title: "
        title = gets.chomp 
        print "Author: "
        author = gets.chomp 
       
        book_instance = Book.new(title, author)
        @all_books.push(book_instance)
        puts "Book created successfully"
    end 

    def create_rental
        puts "Select a book from the following lsit by number"
        @all_books.each_with_index{|bk, index| puts "#{index}) Title: '#{bk.title}', Author: #{bk.author}" }
        book_selected = gets.chomp 

        puts "Select a person from the following list by number (not id)"
        get_all_people.each_with_index{|person, index| puts "#{index}) #{person}"}
        person_selected = gets.chomp
        
        print "Date: "
        date = gets.chomp 

        of_interest = get_all_people[person_selected.to_i]
        id = of_interest.split('ID: ')[1].split(' ')[0].split(',')[0]

        book_obj = @all_books[book_selected.to_i]
        @all_rentals_by_id.push({id: id, book: "#{date}, Book '#{book_obj.title}' by #{book_obj.author}"})

        puts "Rental was created successfully"
    end 

    def get_all_books 
        if @all_books.length == 0 
             return "sorry there are no books saved yet"
        else 
            @all_books.each{|book| puts "TItle: '#{book.title}', Author: #{book.author}"}
        end
    end 

    def get_combined_people 
        if get_all_people.length == 0 
            return "sorry there are no people saved yet"
        else 
            get_all_people.each{|person| puts person}
        end
    end

    def get_all_people 
        combined = []
        @all_people[:students].each{|std| combined.push("[Student] Name: #{std.name}, ID: #{std.id}, Age: #{std.age}")}
        @all_people[:teachers].each{|teacher| combined.push("[Teacher] Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age}")}
        return combined
    end 

    def get_book_rented_by_person(id)
        books_matching_id = @all_rentals_by_id.select{|obj| obj[:id] == id}
        return books_matching_id.map{|bk| bk[:book]}.each{|bkk| puts bkk}
       
    end

    def run 
       while(true)
            puts "\nPlease choose an option by entering a number: \n1 - List all books \n2 - List all people \n3 - Create a person  \n4 - Create a book\n5 - Create a rental \n6 - List all rentals for a given person id\n7 - Exit "
        option = gets.chomp
        case option.to_i
        when 1
            get_all_books
            next
        when 2
            get_combined_people
            next
        when 3
            puts "Do you want to create a student (1) or a teacher (2)? [Input the number]"
            stud_or_teach = gets.chomp 
            case stud_or_teach.to_i
            when 1
                create_student 
            when 2 
                create_teacher
            else 
                puts "You entered a wrong input"
            end
            next
        when 4
            create_book
            next
        when 5 
            create_rental
            next
        when 6
            print "ID of person: "
            user_id = gets.chomp 
            get_book_rented_by_person(user_id)
            next
        when 7 
            break
        else 
            puts 'Sorry you must have entered a wrong entry'
            next
        end
       end
    end 
end