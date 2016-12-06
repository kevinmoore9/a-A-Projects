class CreateContactShares < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.integer :contact_id, presence: true
      t.integer :user_id, presence: true

      t.timestamps
    end
    add_index "contact_shares", ["contact_id", "user_id"],
      name: "index_contact_shares_on_contact_id_and_user_id",
      unique: true, using: :btree

    add_index "contact_shares", ["contact_id"],
      name: "index_contact_shares_on_contact_id", using: :btree

    add_index "contact_shares", ["user_id"],
      name: "index_contact_shares_on_user_id", using: :btree
  end


end
