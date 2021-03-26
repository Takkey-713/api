FactoryBot.define do
  factory :task do
    name {"タスクネーム"}
    explanation {"タスクの説明"}
    deadline_date {"2021/4/1"}
    user
    board
    list
  end
end
