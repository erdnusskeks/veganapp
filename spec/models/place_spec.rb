require 'spec_helper'

describe Place do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lon) }

  it { should validate_numericality_of(:lat) }
  it { should validate_numericality_of(:lon) }
  it { should validate_numericality_of(:rating) }

  describe 'attributes' do
    it { expect(Place.column_names).to_not include('language') }
    it { expect(Place.column_names).to include('rating') }
    it { expect(Place.column_names).to include('slug') }
    it { should allow_mass_assignment_of(:rating) }
    it { should allow_mass_assignment_of(:slug) }
  end

end
