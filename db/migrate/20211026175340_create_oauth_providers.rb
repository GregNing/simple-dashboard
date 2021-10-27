class CreateOauthProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :oauth_providers do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :uid

      t.timestamps
    end
  end
end
