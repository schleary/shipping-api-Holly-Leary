class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :url
      t.text :params
      t.text :response
      t.string :remote_ip
      t.string :request_method
      t.string :status_code

      t.timestamps
    end
  end
end
