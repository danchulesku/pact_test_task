# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'user_name' }
    patronymic { 'patronymic' }
    email { 'email@email.com' }
    nationality { 'Turkish' }
    country { 'Turkey' }
    gender { 'female' }
    surname { 'surname' }
    age { 19 }
  end
end
