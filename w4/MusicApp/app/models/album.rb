# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  band_id    :integer          not null
#  year       :integer          not null
#  live       :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks, dependent: :destroy
end
