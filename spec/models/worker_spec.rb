require 'rails_helper'

RSpec.describe Worker, type: :model do
  it 'has a valid model' do
    expect(Worker.new(attributes_for(:worker))).to be_valid
  end

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }
  it { is_expected.to validate_numericality_of(:status).only_integer }
  it { is_expected.to validate_uniqueness_of(:email) }
  it 'is invalid if email format is not valid' do
    ['@kkk', 'email', 'email@', '.com'].each do |e|
      expect(build(:worker, email: e)).to_not be_valid
    end
  end

  # Associations
  it { is_expected.to have_many(:macro_tasks).dependent(:nullify).with_foreign_key(:created_by) }
  it { is_expected.to have_many(:tokens).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:micro_tasks).join_table('micro_tasks_workers') }

  # Enumerations
  it 'returns enumerations values for status' do
    worker = Worker.new
    statuses = %w(inactive active)
    statuses.each_with_index do |s, i|
      worker.status = i
      expect(worker.status_humanize).to eq(I18n.t("enumerations.status.#{s}"))
    end
  end
end
