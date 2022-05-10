class ChangeStatusDefaultInEnrollments < ActiveRecord::Migration[7.0]
  def change
    change_column :enrollments, :status, :integer, default: 0
  end
end
