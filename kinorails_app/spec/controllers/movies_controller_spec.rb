require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

    before do
        @movie = Movie.create!({title: "Test title",
                                director: "Test director", 
                                country_of_origin: "Poland",
                                length: 200, 
                                poster_link: nil, 
                                description: nil, 
                                created_at: Time.now, 
                                updated_at: Time.now})

        @user_admin = User.create!({email: "test@test.test",
                                    password: "testtest",
                                    username: "test",
                                    name: "test",
                                    surname: "test",
                                    phone_number: "111 111 111",
                                    created_at: Time.now,
                                    updated_at: Time.now,
                                    role: 1})
    end  

    describe "GET index" do
        it "assigns @movies" do
            get :index
            expect(assigns(:movies)).to eq([@movie])
        end

        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end
    end

    describe "GET new" do
        it "renders new template" do
            sign_in @user_admin

            get :new
            expect(response).to render_template("new")
        end
    end

    describe "GET #show" do
        it "renders the #show view" do
            get :show, params: { id: @movie.id }
            expect(response).to render_template :show
        end
    end

    describe "GET #edit" do
        it "renders the #edit view" do
            sign_in @user_admin

            get :edit, params: { id: @movie.id }
            expect(response).to render_template :edit
        end
    end

    describe "PATCH #update" do
        it "update the wallet and redirect" do
            put :update, params: { id: @movie.id, movie: { :length => 180} }
            expect(response).to be_redirect
        end
    end

    describe "PUT #destroy" do
        it "destroy movie success" do
            sign_in @user_admin

            expect {
                delete :destroy, params: { id: @movie.id}
             }.to change(Movie, :count).by(-1)
        end

        it "destroy movie fail, not admin role" do
            expect {
                delete :destroy, params: { id: @movie.id}
             }.to change(Movie, :count).by(0)
        end
    end
end