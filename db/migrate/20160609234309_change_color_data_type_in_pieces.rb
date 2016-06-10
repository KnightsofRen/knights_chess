class ChangeColorDataTypeInPieces < ActiveRecord::Migration
  def change
    change_column :pieces, :color, 'integer USING CAST(color AS integer)'
  end
end
