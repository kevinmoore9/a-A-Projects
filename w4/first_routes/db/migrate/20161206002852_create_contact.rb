class CreateContact < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index "contacts", ["user_id"], name: "index_contacts_on_user_id",
      using: :btree
  end
end
