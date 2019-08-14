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
    (time_component + distance * car.price_per_km).to_i
  end

  private

  def time_component
    (1..date_interval).to_a.reduce(0) do |sum, d|
      percent = 1.0
      percent -= 0.1 if d > 1
      percent -= 0.2 if d > 4
      percent -= 0.2 if d > 10
      sum + car.price_per_day * percent
    end
  end
end
