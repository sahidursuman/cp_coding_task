class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :country
      t.string :external
      t.string :photo
      t.datetime :published_at

      t.timestamps
    end
  end
end
