FactoryBot.define do
  factory :task do
    title    {"test"}
    content  {"content"}
    status   {:todo}
    deadline {1.days.from_now}
    association :user
  end
end
