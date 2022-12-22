require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
    before do
        sign_in(user)
        current_user=user
    end
    
    describe "subcategory create" do
        render_views
        let(:user) {User.create(name:"anjali",email:"dunje@ci.com",role:"Admin",password: "1234545")}
        let(:category1) {Category.create(name:"toys")}
        
        it "subcategory create with correct params" do
            category_params= { category: {name:"shirt",parent_id: category1.id} }
            post :create,params: category_params
            redirect_to categories_path
        end

        it "subcategory create without correct params" do
            category_params= { category: {name:nil, parent_id: category1.id} }
            post :create,params: category_params
            get :new
            expect(response.status).to eq(200)
        end

        it "category create" do
            category_params= { category: { name:"shirt" } }
            post :create,params: category_params
            redirect_to categories_path
        end
        
        it "category create without correct params" do
            category_params= { category: { name:nil } }
            post :create,params: category_params
            get :new
            expect(response.status).to eq(200)
        end
    end

    describe "subcategory update" do
        render_views
        let(:user) {User.create(name:"anjali",email:"dunje@ci.com",role:"Admin",password: "1234545")}
        let(:category1) {Category.create(name:"toys")}
        
        it "subcategory create with correct params" do
            category_params= { category: {parent_id: nil} ,id: category1.id }
            put :update,params: category_params
            expect(response.status).to eq(302)
        end

        xit "subcategory create without correct params" do
            category_params= { category: {name:nil, parent_id: 5} ,id: category1.id }
            post :update,params: category_params
            get :edit
        end

        xit "category create" do
            category_params= { category: { name:"shirt" } ,id: category1.id}
            post :create,params: category_params
            redirect_to category_path(category1.id)
        end
        
        xit "category create without correct params" do
            category_params= { category: { name:nil } ,id: category1.id}
            post :create,params: category_params
            get :new
            expect(response.status).to eq(200)
        end
        
    end
end
 