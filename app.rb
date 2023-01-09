require './rental'
require './student'
require './book'
require './teacher'

class App
  def show_books(books)
    if books.empty?
      puts 'No books found in library'
    else
      books.each do |book|
        puts "title: #{book.title}, Auther: #{book.author}"
      end
    end
  end

  def show_people(people)
    if people.empty?
      puts 'No person found'
    else
      people.each do |person|
        puts "Name: #{person.name}, Age: #{person.age},ID: #{person.id}"
      end
    end
  end

  def add_people(people)
    print('press 1 to add a student or press 2 to add a teacher')
    person_to_add = gets.chomp.to_i
    print 'Age? '
    age = gets.chomp.to_i
    print 'Name? '
    name = gets.chomp

    case person_to_add
    when 1
      print 'Do you have parent Permission? [Y/N]:'
      user_response = gets.chomp.capitalize
      user_permission = true if user_response == 'Y'
      user_permission = false if user_response == 'N'
      people.push(Student.new(nil, age, name, parent_permission: user_permission))
    when 2
      print 'Specialisation?'
      specialisation = gets.chomp
      people.push(Teacher.new(specialisation, age, name))
    end
    puts 'Person added successfully'
  end

  def add_book(books)
    puts 'Please Add a book'
    print 'Title :'
    title = gets.chomp.capitalize
    print 'Author:'
    author = gets.chomp.capitalize
    books.push(Book.new(title, author))
    puts 'Book added successfully'
  end

  def add_rental(books, people, rental_data)
    puts 'Please select abook from the list by number'
    books.map.with_index { |book, index| puts "#{index} Title: #{book.title}',Auther:#{book.author}" }
    selected_book = gets.chomp.to_i
    puts "Choose a person from the list:(
      DON'T CHOOSE ID PLEASE)"
    people.map.with_index do |person, index|
      puts "#{index}, Name: #{person.name} Age: #{person.age},
          ID:#{person.id}"
    end
    selected_person = gets.chomp.to_i

    print 'date?'
    selecteted_date = gets.chomp
    rental_data.push(Rental.new(selecteted_date, people[selected_person], books[selected_book]))
    puts 'rental_data updated'
  end

  def show_rental_data(rentals)
    print 'Person ID'
    selected_person_id = gets.chomp.to_i
    rentals.each do |rental|
      next unless rental.person.id == selected_person_id

      puts rental.book.title
      puts rental.person.name
      puts rental.date
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

  def options(books, people, rental_data)
    loop do
      display_all
      option = gets.chomp.to_i
      case option
      when 1
        show_books(books)
      when 2
        show_people(people)
      when 3
        add_people(people)
      when 4
        add_rental(books, people, rental_data)
      when 5
        add_book(books)
      when 6
        show_rental_data(rental_data)
      else
        break
      end
    end
  end
end
