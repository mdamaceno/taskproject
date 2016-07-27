class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :projects do |t|
      t.string :title, null: false, default: ''
      t.text :notes
      t.date :begin_at, null: false
      t.date :finish_at

      t.timestamps
    end
  end
end
