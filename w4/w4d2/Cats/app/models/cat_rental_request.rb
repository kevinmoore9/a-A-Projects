# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :Cat

  validates(
  :cat_id,
  :end_date,
  :start_date,
  :status,
  presence: true
  )
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :check_for_overlapping_approved_requests

  def overlapping_requests
    overlaps = []
    cat = self.cat
    cat.cat_rental_requests.all.each do |request|
      if (request.start_date < self.end_date && request.start_date > self.start_date) ||
        (request.end_date > self.start_date && request.end_date < self.end_date)
        overlaps << request
      end
    end
    overlaps
  end

  def overlapping_approved_requests
    approved_overlaps = []
    overlapping_requests.each do |overlap|
      approved_overlaps << overlap if overlap.status == "APPROVED"
    end
    approved_overlaps
  end

  def check_for_overlapping_approved_requests
    overlapping_approved_requests.empty?
  end

  def approve!
    #raise "not pending" unless self.status == "PENDING"
    transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_requests.each do |request|
        next if request == self
        request.status = "DENIED"
        request.save!
      end
    end
  end

  def deny!
    transaction do
      self.status = "DENIED"
      self.save!
    end
  end 

end
