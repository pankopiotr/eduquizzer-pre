# frozen_string_literal: true

@admin = User.create(email: 'admin@example.com', password: 'admin123',
                     first_name: 'John', last_name: 'Doe', student_id: '000000',
                     activated: true, admin: true)

(1..15).each_with_index do |_user, index|
  User.create(email: "user#{index}@example.com", password: "user00#{index}",
              activated: true)
end

(1..50).each_with_index do |_task, index|
  Task.create(name: "Task no #{index}", task_type: 'Close-ended',
              category: 'Seeds', asset: File.open('public/uploads/task/asset/2/a9537c16-7ce1-4c78-af4b-9a9d79221309.png'),
              correct_solutions: ['First correct answer', 'Second correct answer'],
              wrong_solutions: ['First wrong solution', 'Second wrong solution'],
              score: index, author: @admin)
end