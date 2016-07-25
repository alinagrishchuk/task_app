module Messenger
  module TaskMessengerUtilities
    def prepare_partial(event)
      if event == 'task.destroyed'
        'tasks/messenger/destroyed_event'
      else
        'tasks/messenger/saved_event'
      end
    end

    def prepare_task (data, user)
      task = eval(data)['task'].deep_symbolize_keys
      allowed_notify?(task, user) ? task : nil
    end

    private
      def allowed_notify? (task, user)
        task[:users].map{ |user| user[:id] }.include? user
      end
  end
end