require 'rails_helper'

RSpec.describe User, type: :model do
  context "when passing valid parameters to the name method"

  let!(:data) { {email:"anjali@test.com",uid:"14523698788",name:"anjali"} }
  let!(:user) { User.from_google data}
  
  before(:all) do
    puts "run before all test"
  end
  
  it "googgle" do
    debugger
    allow(user).to receive(:name).and_return('example_value')
  end
  
  it "user_name" do 
    expect(User.user_name user.id).to eq("Anjali")

  end

end
