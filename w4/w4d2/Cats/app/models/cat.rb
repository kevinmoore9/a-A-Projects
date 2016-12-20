# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date
#  color       :string
#  name        :string           not null
#  sex         :string(1)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base

  has_many :cat_rental_requests, :dependent=> :destroy

  validates :name, presence: true
  validates :color, inclusion: { in: %w(Green Black Red) }
  #
  def age
    (Date.current - self.birth_date).to_i / 365
  end


end
