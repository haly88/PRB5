class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
