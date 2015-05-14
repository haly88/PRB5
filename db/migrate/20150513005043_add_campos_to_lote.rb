class AddCamposToLote < ActiveRecord::Migration
  def change
    add_column :lotes, :localidad, :string
    add_column :lotes, :area, :decimal, :precision => 12, :scale => 4, :default => 0 
  end
end
