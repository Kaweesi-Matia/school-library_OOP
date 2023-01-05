require './app'
def main
  books = []
  rental_data = []
  people = []

  options(books, people, rental_data)
end

def display_all
  puts 'Welcome to the school library'
  puts ' Please choose a task  basing on the number '
  puts "   1:  Show all books.
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

main
