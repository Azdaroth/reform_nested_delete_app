class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :article_id
      t.string :name

      t.timestamps
    end
  end
end
