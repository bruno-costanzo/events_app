# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :enrollments
  has_many :attendees, through: :enrollments, source: :user
  has_one_attached :cover do |attachable|
    attachable.variant :index, resize_to_fill: [250, 150], saver: { quality: 60 }
    attachable.variant :show, resize_to_fill: [1200, 800], saver: { quality: 30 }
  end

  validates :name, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validates :host, presence: true

  scope :past, -> { where('date < ?', Date.today) }
  scope :future, -> { where('date >= ?', Date.today) }

  scope :public_event, -> { where(private: false) }
  scope :private_event, -> { where(private: true) }

  def invited_users
    attendees.where(id: enrollments.where(status: 0).pluck(:user_id))
  end
end
