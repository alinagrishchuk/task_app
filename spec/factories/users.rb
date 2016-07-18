FactoryGirl.define do
  sequence(:email) { |n| "email#{n}@example.com" }

  factory :user do
    email
    password              'foobar12'
    password_confirmation 'foobar12'

    factory :user_with_tasks do
      transient do
        tasks_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:task, evaluator.tasks_count, user: user)
      end
    end
  end
end
