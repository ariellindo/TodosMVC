class CreateTodos < ActiveRecord::Migration
  def self.up
create_table :todos do |t|
  t.string :title
      t.integer :order
      t.integer :done
  t.timestamps
end
  end

  def self.down
    drop_table :todos
  end
end
