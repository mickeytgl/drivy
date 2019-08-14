require_relative 'main.rb'
require 'rspec'

RSpec.describe Main do
  it 'reads the input' do
    result = Main.run
    expect(result).to eq $output.to_json
  end
end
