module Messenger
  module MessageFactory
    def create_task_message task
      message = {}
      message[:task] =  task.as_json(methods: :permalink)
      message[:task][:users] =  task.users.as_json(methods: :permalink)
      message.as_json
    end
  end
end