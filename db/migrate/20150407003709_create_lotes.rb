class CreateLotes < ActiveRecord::Migration
  def change
    create_table :lotes do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
