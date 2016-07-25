module Publisher
  class TaskPublisher
    include Messenger::MessageFactory

    def initialize(task)
      @task = task
    end

    def save
      @task.save && set_message && publish
    end

    def update task_params
      @task.update(task_params) && set_message && publish
    end

    def destroy
      set_message && @task.destroy && publish('task.destroyed')
    end

    private
      def set_message
        @message = create_task_message(@task)
      end

      def publish (event = 'task.saved')
        $redis.publish(event, @message)
      end
  end
end