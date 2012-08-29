require 'spec_helper'

describe AppController do

  describe "#show" do
    it "returns successfully" do
      get :show
      response.should be_success
    end
  end

end
