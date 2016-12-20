class AddDefaultToCrr < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :status, :string, :default=>"PENDING"
  end
end
