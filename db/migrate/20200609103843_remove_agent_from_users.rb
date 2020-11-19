class RemoveAgentFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :agent, :boolean
  end
end
