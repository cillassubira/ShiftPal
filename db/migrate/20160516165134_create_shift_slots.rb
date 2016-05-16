class CreateShiftSlots < ActiveRecord::Migration
  def change
    create_table :shift_slots do |t|
      t.string :slot
      t.timestamps null: false
    end
  end
end
