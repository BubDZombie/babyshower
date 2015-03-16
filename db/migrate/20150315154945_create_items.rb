class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_url
      t.string :link
      t.decimal :msrp, :precision => 2
      t.boolean :available, :default => 1
      t.timestamps null: false
    end
  end
end
