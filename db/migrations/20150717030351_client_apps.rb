Hanami::Model.migration do
  change do
    create_table :client_apps do
      primary_key :id

      column :name,        String,   null: false
      column :app_id,      String,   null: false
      column :app_secret,  String,   null: false
      column :permissions, String,   null: false

      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :updated_at,  DateTime, null: false
      column :created_at,  DateTime, null: false

      index :app_id, unique: true
      index [:app_id, :app_secret], unique: true
    end
  end
end
