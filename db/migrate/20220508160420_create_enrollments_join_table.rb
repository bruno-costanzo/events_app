# frozen_string_literal: true

class CreateEnrollmentsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :status, default: nil
      t.timestamps
    end
  end
end
