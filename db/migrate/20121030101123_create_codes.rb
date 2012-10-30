class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.text :code
      t.string :title
      t.string :type
      t.text :description
      t.integer :author
      t.time :created_at

      t.timestamps
    end
  end
end
