class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
