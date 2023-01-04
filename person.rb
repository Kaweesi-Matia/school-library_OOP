require './nameable'
require './trimmer_decorator'
require './capitalize_decorator'
require './rental'

class Person < Nameable
  attr_accessor :name, :age, :id, :rental_data

  def initialize(age, id, name = 'unknown', parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental_data = []
  end

  def of_age?
    age >= 18
  end

  def can_use_services?
    true if of_age? || @parent_permission
  end

  def correct_name
    @name
  end
end
