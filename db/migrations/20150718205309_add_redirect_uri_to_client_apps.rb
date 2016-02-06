Hanami::Model.migration do
  change do
    add_column :client_apps, :redirect_uri, String, null: false
  end
end
