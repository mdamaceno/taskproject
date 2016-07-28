require 'rails_helper'

RSpec.describe Project::MicroTask::BreakPoint, type: :model do
  before do
    create(:project)
    create(:macro_task)
  end

  let(:worker) { create(:worker) }
  let(:micro_task) { create(:micro_task) }

  it 'has a valid model' do
    expect(Project::MicroTask::BreakPoint.new(attributes_for(:micro_task_break_point))).to be_valid
  end

  it { is_expected.to validate_presence_of(:worker) }
  it { is_expected.to validate_presence_of(:micro_task) }
  it { is_expected.to validate_presence_of(:opened).on(:update) }

  it do
    expect(build(:micro_task_break_point, worker: nil, micro_task: micro_task)).to_not be_valid
  end
end
