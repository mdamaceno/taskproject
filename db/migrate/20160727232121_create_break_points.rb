class CreateBreakPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :project_micro_task_break_points do |t|
      t.references :worker, foreign_key: true
      t.references :project_micro_task, foreign_key: true
      t.integer :opened, null: false, default: 0

      t.timestamps
    end
  end
end
