class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.references :department, null: false, foreign_key: true,  default: 1
      t.text :message
      t.string :subject
      t.datetime :started_at
      t.datetime :resolved_at
      t.datetime :closed_at
      t.integer :status, null: false
      t.integer :priority,  null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
