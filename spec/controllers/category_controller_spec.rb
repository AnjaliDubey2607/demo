require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
    describe "abcd" do
        let(:user) {User.create(name:"anjali",email:"dunje@ci.com",role:"Admin",password: "1234545")}
        let(:category) {Category.create(name:"toys")}
            it "dfg" do
                debugger
                sign_in(user)
                current_user=user
                category_params={name:"shirt"}
                post :create,params: {name:"shirt",parent_id:1}
        expect(parent_id).to eq(nil)
    end
end

end
