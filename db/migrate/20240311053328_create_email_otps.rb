class CreateEmailOtps < ActiveRecord::Migration[7.1]
  def change
    create_table :email_otps do |t|
      t.integer :otp
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
