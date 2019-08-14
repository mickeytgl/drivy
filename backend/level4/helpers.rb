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
