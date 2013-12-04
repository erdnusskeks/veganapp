# encoding: utf-8
require 'spec_helper'

describe PlacesController do
  let!(:place) { FactoryGirl.create(:place) }

  describe '#index' do
    before { get :index }
    subject { response }

    it { should be_success }
    it { should render_template :index }
    it { expect(assigns[:places]).to include(place) }
  end

  describe '#show' do
    before { get :show, id: place.id }
    subject { response }

    it { should be_success }
    it { should render_template :show }
    it { expect(assigns[:place]).to eql(place) }
  end

  describe '#new' do
    before { get :new }
    subject { response }

    it { should be_success }
    it { should render_template :new }
    it { expect(assigns[:place]).to be_new_record }
  end

  describe '#edit' do
    before { get :edit, id: place.id }
    subject { response }

    it { should be_success }
    it { should render_template :edit }
    it { expect(assigns[:place]).to eql(place) }
  end

  describe '#update' do
    before { put :update, id: place.id, place: { name: "New name" } }
    subject { response }

    it { should redirect_to place }
    it { expect(assigns[:place].name).to eql("New name") }
  end

  describe '#destroy' do
    before { delete :destroy, id: place.id }
    subject { response }

    it { should redirect_to places_url }
    it { expect(assigns[:place]).to be_destroyed }
  end

end