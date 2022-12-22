require 'rails_helper'

RSpec.describe User, type: :model do
  context "from_google" do
    it "valid parameters from google" do
      data= {email:"anjali@test.com",uid:"14523698788",name:"anjali"}
      user=User.from_google(data)
    end

    it "invalid parameter" do
      data = {email:"anjali@test.com",uid:"14523698788"}
      user=User.from_google(data)
    end
  end
end