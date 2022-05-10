# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :hosted_events, class_name: 'Event', foreign_key: 'host_id'
  has_many :enrollments, foreign_key: 'user_id'
  has_many :attended_events, through: :enrollments, source: :event

  scope :uninvited_to, ->(event) { all.where.not(id: event.attendees.pluck(:id)) }

  def host?(event)
    hosted_events.include?(event)
  end
end
