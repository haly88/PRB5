class AddCordenadasToLote < ActiveRecord::Migration
  def change
    add_column :lotes, :cordenadas, :string
  end
end
