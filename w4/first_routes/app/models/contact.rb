# create_table "contacts", force: :cascade do |t|
#   t.string   "name",       null: false
#   t.string   "email",      null: false
#   t.integer  "user_id",    null: false
#   t.datetime "created_at"
#   t.datetime "updated_at"


class Contact < ActiveRecord::Base

  belongs_to :owner,
    foreign_key: :user_id,
    class_name: :User

  has_many :contact_shares
  has_many :shared_users,
    through: :contact_shares,
    source: :user

  validates :name, :email, :owner, presence: true
  validates :email, uniqueness: { scope: :user_id }
end
