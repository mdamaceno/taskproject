class CreateWorkers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :workers do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: '', unique: true, index: true
      t.string :password, null: false, default: ''
      t.integer :role, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
