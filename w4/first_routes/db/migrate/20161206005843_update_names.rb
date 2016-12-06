class UpdateNames < ActiveRecord::Migration
  def change
    rename_column :contact_shares, :user_id, :shared_user_id
  end
end
