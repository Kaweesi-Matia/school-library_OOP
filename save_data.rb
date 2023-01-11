require 'json'

module DataSaver
  def get_data(file)
    path_file = "./store_data/#{file}.json"
    File.new(path_file, 'w+') unless File.exist?(path_file)
    File.write(path_file, '[]') if File.empty?(path_file)
    file_contents = File.read(path_file)
    JSON.parse(file_contents)
  end

  def update_data(file, data)
    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }
    json = JSON.generate(data, opts)
    File.write("./store_data/#{file}.json", json)
  end

  def show_books
    get_data('books').map { |item| Book.new(item['title'], item['author']) }
  end

  def show_people
    get_data('people').map do |item|
      case item['class']
      when 'student'
        Student.new(item['age'], item['permission'], item['name'])
      when 'teacher'
        Teacher.new(item['age'], item['specialization'], item['name'])
      else
        []
      end
    end
  end

  def show_rentals(book, people)
    get_data('rental').map { |item| Rental.new(item['date'], book[item['book_index']], people[item['person_index']]) }
  end
end
