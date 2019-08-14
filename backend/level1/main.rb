require 'json'
require 'date'
require_relative 'car.rb'
require_relative 'rental.rb'

$input = JSON.parse(File.read('./data/input.json'))
$output = JSON.parse(File.read('./data/expected_output.json'))

class Main
  class << self
    def run
      create_cars_instances
      create_rentals_instances
      response_hash
    end

    private

    def create_cars_instances
      $cars = $input['cars'].map { |attrs| Car.new attrs: attrs }
    end

    def create_rentals_instances
      $rentals = $input['rentals'].map { |attrs| Rental.new attrs: attrs }
    end

    def response_hash
      {
        rentals:
          $rentals.map { |rental| { id: rental.id, price: rental.price } }
      }.to_json
    end
  end
end

Main.run
