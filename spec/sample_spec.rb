require 'spec_helper'

describe 'Sample' do

  let(:obj) do
    Objectifier.define do
      item :name, type: :string
      item :email, type: :string
      item :dob, type: :string, required: false
      items :skills, type: :string, required: false
      map :location do
        item :lat, type: :float
        item :lng, type: :float
      end
    end
  end

  let(:result) { obj.call(input) }

  let(:data) { subject.value }

  subject { result }

  describe 'given a hash containing all items' do
    let(:input) do
      {
        'name' => 'Wiggly',
        'email' => 'wiggly@example.com',
        'dob' => '1923-01-01',
        'skills' => ['running', 'coding'],
        'location' => {
          'lat' => 0.12344,
          'lng' => 54.1231,
        },
      }
    end

    it { is_expected.to be_success }

    it 'contains the correct data' do
      expect(data['name']).to eq 'Wiggly'
      expect(data['email']).to eq 'wiggly@example.com'
      expect(data['dob']).to eq '1923-01-01'
      expect(data['skills']).to eq ['running', 'coding']
      expect(data['location']['lat']).to eq 0.12344
      expect(data['location']['lng']).to eq 54.1231
    end
  end


  describe 'without a single required item' do
    let(:input) do
      {
        'email' => 'wiggly@example.com',
        'dob' => '1923-01-01',
        'skills' => ['running', 'coding'],
        'location' => {
          'lat' => 0.12344,
          'lng' => 54.1231,
        },
      }
    end

    it { is_expected.not_to be_success }

    # TODO: fix the naming...
    it 'contains an error message for the missing item' do
      expect(result).to include('.name')
    end
  end

  describe 'without a single optional item' do

  end

end
