require './app'
class Main
  def main
    app = App.new
    books = []
    rental_data = []
    people = []
    app.options(books, people, rental_data)
  end
end

main = Main.new

main.main
