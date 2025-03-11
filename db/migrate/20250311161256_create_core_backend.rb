# frozen_string_literal: true

class CreateCoreBackend < ActiveRecord::Migration[7.1]
  def change
    create_enum :gender_enum, %w[male female]

    create_table :users do |t|
      t.string :name, null: false
      t.string :surname
      t.string :full_name
      t.string :patronymic, null: false
      t.string :email, null: false, index: { unique: true }
      t.integer :age, null: false
      t.string :nationality, null: false
      t.string :country, null: false
      t.enum :gender, enum_type: 'gender_enum', null: false

      t.timestamps
    end

    create_table :skills do |t|
      t.string :name, null: false, index: { unique: true }
    end

    create_table :interests do |t|
      t.string :name, null: false, index: { unique: true }
    end

    create_join_table :users, :interests do |t|
      t.index :user_id
      t.index :interest_id
      t.index %i[user_id interest_id], unique: true
    end

    create_join_table :users, :skills do |t|
      t.index :user_id
      t.index :skill_id
      t.index %i[user_id skill_id], unique: true
    end
  end
end
