class CreateMicroTasksWorkers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :micro_tasks_workers, id: false do |t|
      t.uuid :worker_id
      t.uuid :micro_task_id
    end
    add_foreign_key :micro_tasks_workers, :workers, column: :worker_id
    add_foreign_key :micro_tasks_workers, :micro_tasks, column: :micro_task_id
    add_index :micro_tasks_workers, :worker_id
    add_index :micro_tasks_workers, :micro_task_id
  end
end
