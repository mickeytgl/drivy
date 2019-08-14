class Rental
  attr_reader :id, :car_id, :distance, :date_range
  attr_accessor :options

  def initialize(attrs:)
    @car_id = attrs['car_id']
    @id = attrs['id']
    @distance = attrs['distance']
    @options = []
    @date_range =
      DateRange.new(
        DateTime.parse(attrs['start_date']),
        DateTime.parse(attrs['end_date'])
      )
  end

  def response_hash
    {
      id: id,
      options: options.map(&:type),
      actions:
        payees.map do |payee|
          {
            who: payee.name,
            type: payee.payment_type,
            amount: payee.payment_amount
          }
        end
    }
  end

  private

  def car
    car = $cars.find { |car| car.id == @car_id }
    if car.nil?
      raise StandardError, "No car with id #{@car_id} was found"
    else
      car
    end
  end

  def advertised_price
    time_component + distance * car.price_per_km
  end

  def full_price
    (advertised_price + sum_option_prices).to_i
  end

  def commission
    (advertised_price * 0.3).to_i
  end

  def sum_option_prices
    price_list =
      options.map do |option|
        if option.type == 'additional_insurance'
          option.price * date_range.interval
        else
          option.price
        end
      end
    price_list.inject(0) { |sum, x| sum + x }.to_i
  end

  def payees
    [
      Driver.new(payment_amount: full_price),
      Owner.new(payment_amount: owner_fee),
      Insurance.new(payment_amount: insurance_fee),
      Assistance.new(payment_amount: assistance_fee),
      Drivy.new(payment_amount: drivy_fee)
    ]
  end

  def owner_fee
    extras = options.filter { |option| option.receiver == 'owner' }
    extras_prices = (extras.map(&:price).inject(0, :+)).to_i
    (advertised_price - commission + extras_prices).to_i
  end

  def commission
    (advertised_price * 0.3).to_i
  end

  def insurance_fee
    commission / 2
  end

  def assistance_fee
    date_range.interval * 100
  end

  def drivy_fee
    extras = options.filter { |option| option.receiver == 'drivy' }
    extras_prices =
      (extras.map(&:price).inject(0, :+) * date_range.interval).to_i

    commission - insurance_fee - assistance_fee + extras_prices
  end

  def time_component
    (1..date_range.interval).to_a.reduce(0) do |sum, day|
      percent = 1.0
      percent -= 0.1 if day > 1
      percent -= 0.2 if day > 4
      percent -= 0.2 if day > 10
      sum + car.price_per_day * percent
    end
  end
end
