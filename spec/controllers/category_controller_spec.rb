require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
    fixtures :all
    before do
        user = users(:user)
        sign_in(user)
        current_user = user
    end
    
    describe "subcategory create" do
        render_views
        
        it "subcategory create with correct params" do
            category_params= { category: {name:"shirt",parent_id: categories[0].id} }
            post :create,params: category_params
            redirect_to categories_path
        end

        it "subcategory create without correct params" do
            category_params= { category: {name:nil, parent_id: categories[0].id} }
            post :create,params: category_params
            get :new
            expect(response.status).to eq(200)
        end

        it "category create with correct params" do
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
        # let(:user) {User.create(name:"anjali",email:"dunje@ci.com",role:"Admin",password: "1234545")}
       # let(:category1) {Category.create(name:"toys")}
        
        it "subcategory update with correct params" do
            category_params= { category: {parent_id: nil} ,id: categories[0].id }
            put :update,params: category_params
            expect(response.status).to eq(302)
        end

        it "subcategory update without correct params" do
            category_params= { category: {name: nil} ,id: categories[0].id }
            post :update, params: category_params
            get :new
        end

        it "update category with correct params" do
            category_params= { category: { name:"shirt" } ,id: categories[0].id}
            post :update,params: category_params
            redirect_to category_path(categories[0].id)
        end
        
        it "update category without correct params" do
            category_params= { category: { name:nil } ,id: categories[0].id}
            post :update,params: category_params
            get :new
            expect(response.status).to eq(200)
        end
    end

    describe "subcategory destroy" do
        render_views
        # let(:user) {User.create(name:"anjali",email:"dunje@ci.com",role:"Admin",password: "1234545")}
       # let(:category1) {Category.create(name:"toys")}
        
        it "subcategory destroy" do
            category_params= {id: categories[0].id }
            delete :destroy,params: category_params
            expect(response.status).to eq(302)
        end

    end
end
 