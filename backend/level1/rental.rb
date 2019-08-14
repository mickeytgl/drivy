class Rental
  attr_reader :id, :car_id, :distance

  def initialize(attrs:)
    @car_id = attrs['car_id']
    @id = attrs['id']
    @start_date = DateTime.parse(attrs['start_date'])
    @end_date = DateTime.parse(attrs['end_date'])
    @distance = attrs['distance']
  end

  def car
    $cars.find { |car| car.id == @car_id }
  end

  def date_interval
    (@end_date - @start_date).to_i + 1
  end

  def price
    car.price_per_day * date_interval + distance * car.price_per_km
  end
end
