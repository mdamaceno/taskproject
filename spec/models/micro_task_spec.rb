require 'rails_helper'

RSpec.describe MicroTask, type: :model do
  it 'has a valid model' do
    expect(MicroTask.new(attributes_for(:micro_task))).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:level) }
  it do
    is_expected.to validate_numericality_of(:level)
      .is_greater_than_or_equal_to(1)
      .is_less_than_or_equal_to(5)
  end
  it { is_expected.to belong_to(:macro_task) }

  it 'returns enumerations values for level' do
    micro_task = MicroTask.new
    levels = %w(very_easy easy medium hard very_hard)
    levels.each_with_index do |l, i|
      micro_task.level = i + 1
      expect(micro_task.level_humanize).to eq(I18n.t("enumerations.levels.#{l}"))
    end
  end
end
