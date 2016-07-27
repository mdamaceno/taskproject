require 'rails_helper'

RSpec.describe Project, type: :model do
  it "has a valid model" do
    expect(Project.new(attributes_for :project)).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:begin_at) }
end
