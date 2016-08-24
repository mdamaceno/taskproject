require 'rails_helper'

RSpec.describe BreakPoint, type: :model do
  let(:worker) { create(:worker) }
  let(:project) { create(:project) }
  let(:macro_task) { create(:macro_task, worker: worker) }
  let(:micro_task) { create(:micro_task, macro_task: macro_task) }

  it 'has a valid model' do
    expect(BreakPoint.new(attributes_for(:break_point, worker: worker, micro_task: micro_task))).to be_valid
  end

  it { is_expected.to validate_presence_of(:worker_id) }
  it { is_expected.to validate_presence_of(:micro_task_id) }
  it { is_expected.to validate_presence_of(:opened).on(:update) }

  it do
    expect(build(:break_point, worker: nil, micro_task: micro_task)).to_not be_valid
  end

  it do
    expect(build(:break_point, worker: worker, micro_task: nil)).to_not be_valid
  end
end
