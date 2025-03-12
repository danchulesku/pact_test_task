# frozen_string_literal: true

describe Skill, type: :model do
  it { is_expected.to have_and_belong_to_many(:users) }
  it { is_expected.to validate_presence_of(:name) }
end
