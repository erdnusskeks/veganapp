# encoding: utf-8
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

  it { expect(subject.respond_to?(:description)).to be_true }

  describe '#description' do
    subject { Place.new(name: "Amazing Place", address: "Somewhere 1", city: "Köln", lat: 50.941062, lon: 6.956332) }

    context 'short' do
      it { expect(subject.description(:short)).to eql("Amazing Place (Köln)") }
    end

    context 'long' do
      it { expect(subject.description(:long)).to eql("Amazing Place: Somewhere 1, Köln (Lat: 50.94 | Long: 6.96)") }
    end
  end

  describe '#to_param' do
    subject { Place.create(name: "Delicious Place", address: "Some address 123", city: "Foo", country: "Foo", slug: "delicious-foobar-place", lat: 5.9123, lon: 49.123, rating: 5) }
    it { expect(subject.to_param).to eql("#{subject.id}-#{subject.slug}")}
  end
end
