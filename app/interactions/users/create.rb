class Users::Create < ActiveInteraction::Base
  string :name, :patronymic, :email, :nationality, :country, :gender
  string :surname, default: ''
  integer :age
  array :interests, :skills, type: :string

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'is invalid' }
  validates :gender,
            inclusion: { in: %w[male female], message: 'is not a valid gender. Available genders: male, female' }
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }

  validate :unique_email

  def execute
    user = User.build(user_params)

    user.interests = Interest.where(name: inputs[:interests])
    user.skills = Skill.where(name: inputs[:skills])

    user.save && self.result = user
  end

  private

  def user_params
    inputs.except(:interests, :skills)
          .merge(full_name: "#{inputs[:surname]} #{inputs[:name]} #{inputs[:patronymic]}".strip)
  end

  def unique_email
    errors.add(:email, 'is already taken') if User.exists?(email: email)
  end
end
