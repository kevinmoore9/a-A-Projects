class ContactShare < ActiveRecord::Base

  belongs_to :contact
  belongs_to :user
  
  validates :user_id, :contact_id, presence: true
  validates :contact_id, uniqueness: { scope: :user_id }

end
