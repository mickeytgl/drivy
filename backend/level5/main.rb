require 'pry'
require 'json'
require 'date'
require_relative 'helpers.rb'
require_relative 'rental.rb'

INPUT = JSON.parse(File.read('./data/input.json'))
OUTPUT = JSON.parse(File.read('./data/expected_output.json'))

class Main
  class << self
    def run
      create_cars_instances
      create_rentals_instances
      validate_options_have_correct_rental_ids
      add_options_to_rentals
      result_hash = response_hash
    rescue => e
      error_hash(e)
    else
      result_hash
    end

    private

    def create_cars_instances
      $cars = INPUT['cars'].map { |attrs| Car.new attrs: attrs }
    end

    def create_rentals_instances
      $rentals = INPUT['rentals'].map { |attrs| Rental.new attrs: attrs }
    end

    def response_hash
      { rentals: $rentals.map(&:response_hash) }.to_json
    end

    def validate_options_have_correct_rental_ids
      referenced_rental_ids = INPUT['options'].map { |opt| opt['rental_id'] }
      unless referenced_rental_ids.all? { |id| $rentals.map(&:id).include? id }
        raise StandardError, 'Referenced rental was not found'
      end
    end

    def add_options_to_rentals
      INPUT['options'].each do |option_attributes|
        $rentals.find do |rental|
          rental.id == option_attributes['rental_id']
        end.options <<
          AdditionalFeatures.new(attrs: option_attributes)
      end
    end

    def error_hash(error)
      { status: 500, message: error.message }.to_json
    end
  end
end

Main.run
