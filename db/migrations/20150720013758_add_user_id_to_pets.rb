Hanami::Model.migration do
  change do
    alter_table :pets do
      add_foreign_key :user_id, :users, on_delete: :cascade, null: false, index: true
    end
  end
end
