class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :user_requesting
      t.belongs_to :user_answering
      t.belongs_to :shift_requested
      t.belongs_to :shift_answering
      t.belongs_to :request_status

      t.timestamps null: false
    end
  end
end
