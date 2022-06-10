class CreateRetentionEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :retention_emails do |t|
      t.text :body
      t.date :date_from
      t.date :date_to

      t.timestamps
    end
  end
end
