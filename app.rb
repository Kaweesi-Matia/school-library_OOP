require './rental'
require './student'
require './book'
require './teacher'
require './save_data'

class App
  attr_reader :book, :person, :rental

  include DataSaver

  def initialize
    @book = show_books
    @person = show_people
    @rental = show_rentals(@book, @person)
  end

  def list_books
    if @book.empty?
      puts 'No books found in library'
    else
      book.each do |item|
        puts "title: #{item.title}, Author: #{item.author}"
      end
    end
  end

  def list_people
    if @person.empty?
      puts 'No person found'
    else
      person.each do |item|
        puts "Name: #{item.name}, Age: #{item.age},ID: #{item.id}"
      end
    end
  end

  def add_people
    print('press 1 to add a student or press 2 to add a teacher')
    person_to_add = gets.chomp.to_i
    puts 'Age: '
    age = gets.chomp.to_i
    puts 'Name: '
    name = gets.chomp

    case person_to_add
    when 1
      puts 'Do you have parent Permission? [Y/N]: '
      user_response = gets.chomp.capitalize
      user_permission = true if user_response == 'Y'
      user_permission = false if user_response == 'N'
      people = Student.new(nil, age, name, parent_permission: user_permission)
      student_data_hash = { id: people.id, name: people.name, age: people.age, class: 'student' }
      student_data = get_data('people')
      student_data.push(student_data_hash)
      update_data('people', student_data)
    when 2
      puts 'Specialisation: '
      specialisation = gets.chomp
      people = Teacher.new(specialisation, age, name)
      teacher_data_hash = { id: people.id, name: people.name, age: people.age, class: 'teacher' }
      teach_data = get_data('people')
      teach_data.push(teacher_data_hash)
      update_data('people', teach_data)
    end
    puts 'Person added successfully'
  end

  def add_book
    puts 'Please Add a book'
    print 'Title :'
    title = gets.chomp.capitalize
    print 'Author:'
    author = gets.chomp.capitalize
    book_info = Book.new(title, author)
    book_data_hash = { title: book_info.title, author: book_info.author }
    book_data = get_data('books')
    book_data.push(book_data_hash)
    update_data('books', book_data)
    puts 'Book added successfully'
  end

  def add_rental
    puts 'Please select abook from the list by number'
    book.map.with_index { |item, index| puts "#{index} Title: #{item.title}',Auther:#{item.author}" }
    selected_book = gets.chomp.to_i
    puts "Choose a person from the list:(
      DON'T CHOOSE ID PLEASE)"
    person.map.with_index do |item, index|
      puts "#{index}, Name: #{item.name} Age: #{item.age},
          ID:#{item.id}"
    end
    selected_person = gets.chomp.to_i

    print 'date?'
    selecteted_date = gets.chomp
    puts 'rental_data updated'
    rental_data_hash = { date: selecteted_date, book_index: selected_book, person_index: selected_person }
    rental_data = get_data('rental')
    rental_data.push(rental_data_hash)
    update_data('rental', rental_data)
  end

  def show_rental
    print 'Person ID'
    selected_person_id = gets.chomp.to_i
    @rental.each do |item|
      next unless item.person.id.to_i == selected_person_id

      puts item.book.title
      puts item.person.name
      puts item.date
    end
  end

  def display_all
    puts 'Welcome to the school library'
    puts ' Please choose a task  basing on the number '
    puts "1:  Show all books.
            2:  Show all people.
            3: Create a person
            4: Create a rental
            5: Create a book
            6: List rented books to a person by ID
            7: Exit"
  end

  def options
    loop do
      display_all
      option = gets.chomp.to_i
      case option
      when 1
        list_books
        show_books
      when 2
        list_people
        show_people
      when 3
        add_people
      when 4
        add_rental
      when 5
        add_book
      when 6
        show_rental
      else
        break
      end
    end
  end
end
