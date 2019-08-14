class Car
  attr_reader :id, :price_per_km, :price_per_day

  def initialize(attrs:)
    @id = attrs['id']
    @price_per_day = attrs['price_per_day']
    @price_per_km = attrs['price_per_km']
  end
end

class Assistance
  attr_reader :payment_amount, :name, :payment_type

  def initialize(payment_amount:)
    @payment_amount = payment_amount
    @name = 'assistance'
    @payment_type = 'credit'
  end
end

class Insurance
  attr_reader :payment_amount, :name, :payment_type

  def initialize(payment_amount:)
    @payment_amount = payment_amount
    @name = 'insurance'
    @payment_type = 'credit'
  end
end

class Owner
  attr_reader :payment_amount, :name, :payment_type

  def initialize(payment_amount:)
    @payment_amount = payment_amount
    @name = 'owner'
    @payment_type = 'credit'
  end
end

class Driver
  attr_reader :payment_amount, :name, :payment_type

  def initialize(payment_amount:)
    @payment_amount = payment_amount
    @name = 'driver'
    @payment_type = 'debit'
  end
end

class Drivy
  attr_reader :payment_amount, :name, :payment_type

  def initialize(payment_amount:)
    @payment_amount = payment_amount
    @name = 'drivy'
    @payment_type = 'credit'
  end
end

class DateRange < Struct.new(:start_date, :end_date)
  def interval
    (end_date - start_date + 1).to_i
  end
end

class AdditionalFeatures
  attr_reader :id, :type

  def initialize(attrs:)
    @id = attrs['id']
    @type = attrs['type']
  end

  def price
    case type
    when 'additional_insurance'
      1_000
    when 'baby_seat'
      200
    when 'gps'
      500
    else
      raise StandardError, "#{type} is not a valid additional feature"
    end
  end

  def receiver
    case type
    when 'additional_insurance'
      'drivy'
    when 'baby_seat'
      'owner'
    when 'gps'
      'owner'
    else
      raise StandardError, "#{type} is not a valid additional feature"
    end
  end
end
