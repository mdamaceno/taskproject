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
    association :worker, factory: :worker
  end

  factory :macro_task, class: Project::MacroTask do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    association :project, factory: :project
  end

  factory :micro_task, class: Project::MicroTask do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    level 1
    association :macro_task, factory: :macro_task
  end
end
