class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.date :day
      t.belongs_to :user
      #t.belongs_to :shift_slot
      t.integer :slot
      t.timestamps null: false
    end
  end
end
