require 'rails_helper'

describe UsersController do
  let(:user) { create_user}

  describe "GET #index" do

    it "renders the :index template" do
      user = create_user
      session[:user_id] = user.id
      get :index
      expect(response).to render_template :index
    end
  end

  describe "Permissions" do
    it 'redirects a non-logged in user' do
      get :index
      expect(response).to redirect_to sign_in_path
      expect(flash[:idiot]).to eq "You must register or log in before you can do that!"
    end

    it 'renders 404 if user tries to edit another user' do
      session[:user_id] = user.id

      user2 = create_user(
        first_name: 'Teddi',
        last_name: 'Maull',
        email: "Teddi@gmail.com",
        password: 'password',
        password_confirmation: 'password'
      )
      session[:user_id] = user2.id

      get :edit, id:user.id
      expect(response).to render_template file: '404.html'
    end
  end

  describe "GET #new" do
    it "assigns a new User to @user" do
      session[:user_id] = user.id
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      session[:user_id] = user.id
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "creates a new user when valid parameters are passed" do
      session[:user_id] = user.id
      get :new

      expect {
        post :create, user: { first_name: "Chloe", last_name: "Bradley", email: "Bradley@gschool.com", password: "password" }
      }.to change {User.all.count}.by(1)

      user = User.last

      expect(user.first_name).to eq "Chloe"
      expect(user.last_name).to eq "Bradley"
      expect(user.email).to eq "Bradley@gschool.com"
      expect(response).to redirect_to users_path
    end

    it "does not create a new user if it is invalid" do
      session[:user_id] = user.id
      get :new

      expect {
        post :create, user: { first_name: "Teddi", last_name: nil, email: nil }
      }.to_not change { User.all.count }

      expect(response).to render_template :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      session[:user_id] = user.id
      get :show, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :show template" do
      session[:user_id] = user.id
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "assigns the requested use to @user to be edited" do
      session[:user_id] = user.id
      get :edit, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :edit template" do
      session[:user_id] = user.id
      get :edit, id: user
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    it "locates the requested @user" do
      session[:user_id] = user.id

      patch :update, id: user, user: {
        first_name: user.first_name, last_name: user.last_name, email: user.email
      }
      expect(assigns(:user)).to eq user
    end

    it "changes @user's params" do
      session[:user_id] =  user.id
      patch :update, id: user, user: { first_name: "Jane", last_name: "Doe", email: "janedoe@gmail.com", password: "123" }
      user.reload
      expect(user.first_name).to eq("Jane")
      expect(user.last_name).to eq("Doe")
    end
  end
end
