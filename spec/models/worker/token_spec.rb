require 'rails_helper'

RSpec.describe Worker::Token, type: :model do
  it "has a valid model" do
    expect(Worker::Token.new(attributes_for :worker_token)).to be_valid
  end

  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_length_of(:code).is_equal_to(24) }
  it { is_expected.to belong_to(:worker) }
end
