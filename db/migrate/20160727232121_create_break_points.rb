class CreateBreakPoints < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :break_points do |t|
      t.references :worker, foreign_key: true
      t.references :micro_task, foreign_key: true
      t.integer :opened, null: false, default: 0

      t.timestamps
    end
  end
end
