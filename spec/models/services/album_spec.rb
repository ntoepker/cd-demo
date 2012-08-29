require 'spec_helper'

describe Services::Album do
  it { should allow_mass_assignment_of :artist }
  it { should allow_mass_assignment_of :title }

  context "instantiated" do
    before(:each) do
      @album = FactoryGirl.build(:album)
    end

    it "has a valid factory" do
      @album.should be_valid
    end

    it "requires an artist" do
      FactoryGirl.build(:album, :artist => "").should_not be_valid
    end

    it "requires a title" do
     FactoryGirl.build(:album, :title => "").should_not be_valid
    end
  end
end
