FactoryGirl.define do
  sequence(:title) { |n| "title##{n}" }
  sequence(:description) { |n| "description##{n}" }

  factory :task do
    title
    description

    transient do
      user nil
    end

    before(:create) do |task, evaluator|
      task.users << (evaluator.user || build(:user))
    end
  end

  factory :sample_task, class: Task do
    title
    description
  end
end
