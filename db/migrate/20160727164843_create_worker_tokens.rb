class CreateWorkerTokens < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :worker_tokens do |t|
      t.string :code, null: false, default: ''
      t.datetime :expire_at
      t.references :worker, foreign_key: true

      t.timestamps
    end
    add_index :worker_tokens, :code, unique: true
  end
end
