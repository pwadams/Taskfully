require "rails_helper"

describe ProjectsController do

  let(:user) { create_user }
  let(:admin) { create_admin }
  let(:project) { create_project }

  describe 'GET #index' do
    describe 'Permissions' do
      it 'should render the index view for a logged in user' do
        session[:user_id] = user.id
        get :index
        expect(response).to render_template(:index)
      end

      it 'should redirect to sign in path for a visitor' do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'GET #new' do
    describe 'Permissions' do
      it 'should render new view for logged in user' do

        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end

      it 'should redirect to sign in path for a visitor' do
        get :new
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'POST #create' do
    describe 'Permissions' do
      it 'should create a new project for a logged in user' do

        session[:user_id] = user.id

        expect {
          post :create, project: {name: 'Plan party'}
        }.to change {Project.count}.by(1)

        expect(Membership.last.role).to eq "Owner"
        expect(response). to redirect_to(project_tasks_path(Project.last))
      end

      it 'should create a new project for a logged in user' do

        expect {
          post :create, project: {name: 'Plan party'}
        }.to_not change {Project.count}

        expect(response). to redirect_to sign_in_path
      end
    end
  end

  describe "GET #show" do
    describe 'Permissions' do
      describe "if user is a member" do
        it "assigns the requested project to @project" do
          session[:user_id] = user.id
          create_member(project, user)
          get :show, id: project.id
          expect(assigns(:project)).to eq project
        end
      end

      describe 'if user is a nonmember' do
        it 'redirect to projects show page' do
          session[:user_id] = user.id
          get :show, id: project.id
          expect(response).to redirect_to(projects_path)
        end
      end
    end
  end

  describe  'PUT #update' do
    describe 'Permissions' do
    it 'Owner can update a project' do
        session[:user_id] = user.id
        create_member(project, user, role: 'Owner')
        expect {
          get :update, id: project.id, project: {name: 'plan birthday'}
        }.to change{project.reload.name}
      end
    end
  end
end
