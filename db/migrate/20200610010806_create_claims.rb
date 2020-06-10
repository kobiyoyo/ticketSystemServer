class CreateClaims < ActiveRecord::Migration[6.0]
  def change
    create_table :claims do |t|
      t.integer :agent_id
      t.integer :claimed_ticket_id

      t.timestamps
    end
    add_index :claims, :agent_id
    add_index :claims, :claimed_ticket_id
  end
end
