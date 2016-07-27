require 'rails_helper'

RSpec.describe Project::MacroTask, type: :model do
  it "has a valid model" do
    expect(Project::MacroTask.new(attributes_for :macro_task)).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to belong_to(:worker).with_foreign_key(:created_by) }
  it { is_expected.to have_many(:micro_tasks).dependent(:destroy) }
end
