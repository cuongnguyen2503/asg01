class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :publisher
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :books, [:user_id, :created_at]
  end
end
