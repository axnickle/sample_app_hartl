class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name #type: attribute
      t.string :email

      t.timestamps #gives us 'created_at' and 'updated_at' automatically
    end
  end
end
