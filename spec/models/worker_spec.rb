require 'rails_helper'

RSpec.describe Worker, type: :model do
  it 'has a valid model' do
    expect(Worker.new(attributes_for(:worker))).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:macro_tasks).dependent(:nullify).with_foreign_key(:created_by) }

  it 'is invalid if email format is not valid' do
    ['@kkk', 'email', 'email@', '.com'].each do |e|
      expect(build(:worker, email: e)).to_not be_valid
    end
  end

  it 'returns enumerations values for status' do
    worker = build(:worker, status: 0)
    expect(worker.status_humanize).to eq(I18n.t('enumerations.status.inactive'))
    worker = build(:worker, status: 1)
    expect(worker.status_humanize).to eq(I18n.t('enumerations.status.active'))
  end
end
