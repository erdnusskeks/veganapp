require 'spec_helper'

describe Place do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lon) }

  it { should validate_numericality_of(:lat) }
  it { should validate_numericality_of(:lon) }
end
