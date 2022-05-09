# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :enrollments
  has_many :attendees, through: :enrollments, source: :user

  scope :past, -> { where('date < ?', Date.today) }
  scope :future, -> { where('date >= ?', Date.today) }
end
