# frozen_string_literal: true

class DeviseCreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      ## Database authenticatable
      t.string :username,           null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.datetime :locked_at
      # t.string   :unlock_token # Only if unlock strategy is :email or :both


      t.timestamps null: false
    end

    add_index :managers, :username,             unique: true
    # add_index :managers, :reset_password_token, unique: true
    # add_index :managers, :confirmation_token,   unique: true
    # add_index :managers, :unlock_token,         unique: true
  end
end
