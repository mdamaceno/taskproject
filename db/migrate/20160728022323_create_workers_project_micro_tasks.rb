class CreateWorkersProjectMicroTasks < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :workers_project_micro_tasks do |t|
      t.belongs_to :worker, index: true
      t.belongs_to :project_micro_task, index: true
    end
  end
end
