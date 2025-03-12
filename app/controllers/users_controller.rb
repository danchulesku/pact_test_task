# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    outcome = Users::Create.run(create_params)

    if outcome.valid?
      render json: { user: outcome.result }, status: :created
    else
      render json: { errors: outcome.errors }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:data).permit(:name, :patronymic, :surname, :email, :age, :nationality, :country, :gender,
                                 skills: [], interests: [])
  end
end
