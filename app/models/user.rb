# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :interests

  validates_presence_of :name, :patronymic, :email, :age, :nationality, :country
  validates :gender, inclusion: { in: %w[male female] }
end
