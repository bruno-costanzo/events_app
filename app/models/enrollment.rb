# frozen_string_literal: true

class Enrollment < ApplicationRecord
  enum status: { invited: 0, confirmed: 1 }
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validate :user_already_enrolled
  
  private

  def user_already_enrolled
    errors.add(:user, 'is already enrolled') if event.enrollments.where(user_id: user.id).exists?
  end
end
