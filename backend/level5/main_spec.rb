require_relative 'main.rb'
require 'rspec'

RSpec.describe Main do
  it 'reads the input' do
    result = Main.run
    expect(result).to eq OUTPUT.to_json
  end

  it 'sends an error message if something goes wrong' do
    allow(Main).to receive(:response_hash).and_raise 'this error'
    result = JSON.parse(Main.run)

    expect(result['message']).to match 'this error'
    expect(result['status']).to match 500
  end
end
