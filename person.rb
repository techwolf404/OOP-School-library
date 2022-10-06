require_relative 'nameable'

class Decorator < Nameable
  attr_accessor :nameable

  def initialize(nameable)
    @nameable = nameable
    super()
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    trim = @nameable.correct_name
    trim.length <= 10 ? trim : trim[0...10]
  end
end

class Person < Nameable
  attr_reader :id

  attr_accessor :name, :age, :rentals

  def initialize(age, name, parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def add_rental(book, date)
    Rental.new(date, book, self)
  end

  def correct_name
    @name
  end

  # Public
  def can_use_services?
    of_age? || @parent_permission
  end
  public :can_use_services?

  # Private method
  private

  def of_age?
    if @age >= 18
      true
    elsif @age < 18
      false
    end
  end
end
