class CreateRequestStatuses < ActiveRecord::Migration
  def change
    create_table :request_statuses do |t|
      t.string :status
      t.timestamps null: false
    end
  end
end
