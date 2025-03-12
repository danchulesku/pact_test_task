# frozen_string_literal: true

describe Users::Create, type: :interactor do
  subject(:service_run) { described_class.run(params) }

  let(:params) do
    {
      name: 'John', patronymic: 'Galt', email: 'test@email.com', nationality: 'american',
      country: 'usa', gender: 'male', surname: '', age: 30, interests: %w[money cars], skills: %w[work driving]
    }
  end

  shared_examples 'failing service' do
    it 'does NOT create new user' do
      expect { service_run }.not_to(change { User.count })
    end

    it 'is not valid' do
      expect(service_run.valid?).to eq false
    end
  end

  it 'creates user' do
    expect { service_run }.to change { User.count }.by(1)
  end

  it 'correctly saves full_name' do
    service_run
    expect(User.first.full_name).to eq('John Galt')
  end

  context 'WHEN same skill exists' do
    let!(:skill1) { create(:skill, name: 'work') }
    let!(:skill2) { create(:skill, name: 'driving') }

    it 'assigns same skills to user' do
      service_run
      expect(User.first.skills).to eq([skill1, skill2])
    end
  end

  context 'WHEN same interests exists' do
    let!(:interest1) { create(:interest, name: 'money') }
    let!(:interest2) { create(:interest, name: 'cars') }

    it 'assigns same interests to user' do
      service_run
      expect(User.first.interests).to eq([interest1, interest2])
    end
  end

  context 'WHEN email is invalid' do
    before { params[:email] = 'incorrect_email.' }

    it_behaves_like 'failing service'
  end

  context 'WHEN email is already occupied' do
    before { create(:user, email: params[:email]) }

    it_behaves_like 'failing service'
  end

  context 'WHEN gender is invalid' do
    before { params[:gender] = 'third_gender' }

    it_behaves_like 'failing service'
  end

  context 'WHEN age is invalid' do
    before { params[:age] = -55 }

    it_behaves_like 'failing service'
  end
end
