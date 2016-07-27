class CreateMicroTasks < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :project_micro_tasks do |t|
      t.string :title, null: false, default: ''
      t.text :notes
      t.integer :level, null: false, default: 1
      t.references :project_macro_task, foreign_key: true

      t.timestamps
    end
  end
end
