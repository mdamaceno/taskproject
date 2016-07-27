class CreateMacroTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :macro_tasks do |t|
      t.string :title
      t.text :notes
      t.uuid :created_by
      t.references :project, foreign_key: true

      t.timestamps
    end
    add_foreign_key :macro_tasks, :workers, column: :created_by
    add_index :macro_tasks, :created_by
  end
end
