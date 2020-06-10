class AddDepartmentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :department, foreign_key: true, null: false,  default: 1
  end
end
