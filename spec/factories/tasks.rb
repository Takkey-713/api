FactoryBot.define do
  factory :task do
    name {"タスクネーム"}
    explanation {""}
    deadline_date {""}
    user
    board
  end
end
