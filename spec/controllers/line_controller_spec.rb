require "rails_helper"

RSpec.describe LineController, :type => :controller do
  describe "responds to" do
    it "responds to json by default" do
      expected = { 
        :status  => 200,
        :text     => 'parablast please enigmatically hearthwarming psithurism ecphore organophonic airdrome phlegmatically mealable'
      }.to_json

      get :show, { :id => "4" }

      expect(response.content_type).to eq "application/json"
      response.body.should == expected
    end

    it "responds to json by default" do
      expected = { :status  => 413 }.to_json

      get :show, { :id => "99999999999999999999" }

      expect(response.content_type).to eq "application/json"
      response.body.should == expected
    end
  end
end