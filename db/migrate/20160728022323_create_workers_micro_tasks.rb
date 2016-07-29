class CreateWorkersMicroTasks < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :workers_micro_tasks do |t|
      t.uuid :worker_id
      t.uuid :micro_task_id
    end
    add_foreign_key :workers_micro_tasks, :workers, column: :worker_id
    add_foreign_key :workers_micro_tasks, :micro_tasks, column: :micro_task_id
    add_index :workers_micro_tasks, :worker_id
    add_index :workers_micro_tasks, :micro_task_id
  end
end
