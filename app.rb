require_relative './src/book'
require_relative './src/student'
require_relative './src/teacher'
require_relative './src/rental'

class App
  attr_reader :all_books, :all_people, :all_rentals

  def initialize
    @all_books = []
    @all_people = { students: [], teachers: [] }
    @all_rentals_by_id = []
  end

  def create_student()
    print 'Age: '
    age = gets.chomp
    print 'Classroom: '
    classroom = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Parents permision Y/N: '
    permission = gets.chomp

    student = Student.new(age.to_i, classroom, name, permission.upcase == 'Y' ? 'true' : 'false')
    @all_people[:students].push(student)
    puts 'Student created successfully'
  end

  def create_teacher()
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    print 'Age: '
    age = gets.chomp

    teacher = Teacher.new(specialization, age, name)
    @all_people[:teachers].push(teacher)
    puts 'Teacher created successfully'
  end

  def create_book()
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    book_instance = Book.new(title, author)
    @all_books.push(book_instance)
    puts 'Book created successfully'
  end

  def create_rental()
    puts 'Select a book from the following lsit by number'
    @all_books.each_with_index { |bk, index| puts "#{index}) Title: '#{bk.title}', Author: #{bk.author}" }
    book_selected = gets.chomp

    puts 'Select a person from the following list by number (not id)'
    gt_all_people.each_with_index { |person, index| puts "#{index}) #{person}" }
    person_selected = gets.chomp

    print 'Date: '
    date = gets.chomp

    of_interest = gt_all_people[person_selected.to_i]
    id = of_interest.split('ID: ')[1].split[0].split(',')[0]

    book_obj = @all_books[book_selected.to_i]
    @all_rentals_by_id.push({ id: id, book: "#{date}, Book '#{book_obj.title}' by #{book_obj.author}" })

    puts 'Rental was created successfully'
  end

  def gt_all_books()
    if @all_books.length.zero?
      'sorry there are no books saved yet'
    else
      @all_books.each { |book| puts "TItle: '#{book.title}', Author: #{book.author}" }
    end
  end

  def gt_combined_people()
    if gt_all_people.length.zero?
      'sorry there are no people saved yet'
    else
      gt_all_people.each { |person| puts person }
    end
  end

  def gt_all_people()
    combined = []
    @all_people[:students].each { |std| combined.push("[Student] Name: #{std.name}, ID: #{std.id}, Age: #{std.age}") }
    @all_people[:teachers].each do |teacher|
      combined.push("[Teacher] Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age}")
    end
    combined
  end

  def gt_book_rented_by_person()
    print 'ID of person: '
    id = gets.chomp
    books_matching_id = @all_rentals_by_id.select { |obj| obj[:id] == id }
    books_matching_id.map { |bk| bk[:book] }.each { |bkk| puts bkk }
  end

  # a break down of the bulky run method
  def initial_string()
    puts "\nPlease choose an option by entering a number: \n1 - List all books \n2 - List all people"
    puts "3 - Create a person  \n4 - Create a book\n5 - Create a rental"
    puts "6 - List all rentals for a given person id\n7 - Exit "
  end

  def steps_in_creating_person()
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]'
    stud_or_teach = gets.chomp
    case stud_or_teach.to_i
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'You entered a wrong input'
    end
  end

  def run
    loop do
      initial_string
      option = gets.chomp
      case option.to_i
      when 1 then gt_all_books
                  next
      when 2 then gt_combined_people
                  next
      when 3 then steps_in_creating_person
                  next
      when 4 then create_book
                  next
      when 5 then create_rental
                  next
      when 6 then gt_book_rented_by_person
                  next
      else break
      end
    end
  end
end
