FactoryGirl.define do
  factory :project do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    begin_at Time.now
    finish_at nil
  end

  factory :worker do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'supersecret'
    role 0
    status 0
  end

  factory :worker_token, class: Worker::Token do
    code SecureRandom.base64
    expire_at Time.now + 1.day
    association :worker, factory: :worker, strategy: :create
  end

  factory :macro_task do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    association :project, factory: :project, strategy: :create
    created_by FactoryGirl.create(:worker).id
  end

  factory :micro_task do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    level 1
    macro_task_id FactoryGirl.create(:macro_task).id
    workers { [FactoryGirl.create(:worker)] }
  end

  factory :break_point do
    opened 0
    worker_id nil
    micro_task_id nil
  end
end
