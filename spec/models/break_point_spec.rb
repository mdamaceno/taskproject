require 'rails_helper'

RSpec.describe BreakPoint, type: :model do
  before do
    create(:project)
    create(:macro_task)
  end

  let(:worker) { create(:worker) }
  let(:micro_task) { create(:micro_task) }

  it 'has a valid model' do
    expect(BreakPoint.new(attributes_for(:break_point))).to be_valid
  end

  it { is_expected.to validate_presence_of(:worker) }
  it { is_expected.to validate_presence_of(:micro_task) }
  it { is_expected.to validate_presence_of(:opened).on(:update) }

  it do
    expect(build(:break_point, worker: nil, micro_task: micro_task)).to_not be_valid
  end
end
