class Changestatus < ActiveRecord::Migration[7.0]
  def change
    change_column :enrollments, :status, :integer, default: nil
  end
end
