class Rental
  attr_accessor :date, :book, :person

  def initialize(date)
    @date = date
    @book = book
    book.rental_data << self
    @person = person
    person.rental_data << self
  end
end
