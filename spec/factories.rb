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
    worker { create(:worker) }
  end

  factory :macro_task, class: Project::MacroTask do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    project { create(:project) }
  end

  factory :micro_task, class: Project::MicroTask do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    level 1
    macro_task { create(:macro_task) }
  end

  factory :micro_task_break_point, class: Project::MicroTask::BreakPoint do
    opened 0
    worker { create(:worker) }
    micro_task { create(:micro_task) }
  end
end
