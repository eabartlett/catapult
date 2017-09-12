class CreateBreedTagJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :breeds, :tags do |t|
      t.index :breed_id
      t.index :tag_id
    end
  end
end
