require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'

class Person < Nameable
  attr_accessor :age, :name, :id, :rental_data

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental_data = []
  end

  def can_use_services?
    true if is_of_age || @parent_permission
  end

  def of_age?
    @age >= 18
  end

  def correct_name
    @name
  end

  def add_rental_data(date, book)
    Rental.new(date, self, book)
    rental_data.push(self)
  end
end
