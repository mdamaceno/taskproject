class CreateWorkers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :workers do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :password, null: false, default: ''
      t.integer :role, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :workers, :email, unique: true
  end
end
