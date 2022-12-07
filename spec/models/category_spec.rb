require 'rails_helper'

RSpec.describe Category, type: :model do

  before(:each) do 
    puts "Runs before each Example" 
 end 
 
  after(:each) do 
      puts "Runs after each Example" 
  end 

  it "parent category" do
    Category.create(name:"mobile")
    Category.create(name:"mobile2",parent_id:1)
    allow(Category.category)

    expect(Category.category_name.pluck(:parent_id)).to include(1)
  end


  it "unique_name" do
    Category.create(name:"mobile")
    Category.create(name:"mobile2",parent_id:1)
    Category.create(name:"mobile2",parent_id:1)
  end
end
