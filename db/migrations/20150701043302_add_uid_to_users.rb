Hanami::Model.migration do
  change do
    add_column :users, :uid, String
  end
end
