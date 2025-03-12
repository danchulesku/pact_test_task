# frozen_string_literal: true

describe User, type: :model do
  it { is_expected.to have_and_belong_to_many(:skills) }
  it { is_expected.to have_and_belong_to_many(:interests) }
end
