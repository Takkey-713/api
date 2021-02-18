json.array! @tasks do |task|
  json.id task.id
  json.name task.name
  json.explanation task.explanation
  json.deadlineDate task.deadline_date
  json.status task.status
  json.boardId task.board_id
end