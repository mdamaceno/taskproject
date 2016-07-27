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

  factory :macro_task do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    association :project, factory: :project

    factory :macro_task_with_project do
      after(:create) do |project|
        create(:project, project: macro_task.project)
      end
    end
  end

  factory :micro_task do
    title { Faker::Name.title }
    notes { Faker::Lorem.sentence(3) }
    level 1
    association :macro_task, factory: :macro_task

    factory :micro_task_with_macro_task do
      after(:create) do |project|
        create(:macro_task, macro_task: micro_task.macro_task)
      end
    end
  end
end
