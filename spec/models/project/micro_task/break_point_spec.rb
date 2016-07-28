require 'rails_helper'

RSpec.describe Project::MicroTask::BreakPoint, type: :model do
  it 'has a valid model' do
    expect(Project::MicroTask::BreakPoint.new(attributes_for(:micro_task_break_point))).to be_valid
  end

  it { is_expected.to validate_presence_of(:worker) }
  it { is_expected.to validate_presence_of(:micro_task) }
  it { is_expected.to validate_presence_of(:opened).on(:update) }
  it { is_expected.to belong_to(:worker) }
  it { is_expected.to belong_to(:micro_task) }
end
