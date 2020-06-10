class CreateItems < ActiveRecord::Migration[5.0]
  def up
    create_table :items do |t|
      t.string :code
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end

  def down
    drop_table :items
  end
end
