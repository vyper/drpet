Hanami::Model.migration do
  change do
    add_column :pets, :image_id, String
  end
end
