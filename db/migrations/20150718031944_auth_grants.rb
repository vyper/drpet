Hanami::Model.migration do
  change do
    create_table :auth_grants do
      primary_key :id

      column :code,          String, null: false
      column :access_token,  String, null: false
      column :refresh_token, String, null: false
      column :permissions,   String, null: false

      foreign_key :client_app_id, :client_apps, on_delete: :cascade, null: false
      foreign_key :user_id,       :users,       on_delete: :cascade, null: false

      column :updated_at,  DateTime, null: false
      column :created_at,  DateTime, null: false

      index :code,                      unique: true
      index :access_token,              unique: true
      index :refresh_token,             unique: true
      index [:client_app_id, :user_id], unique: true
    end
  end
end
