require "rails_helper"


describe MembershipsController do

  let(:user) {create_user}
  let(:admin) {create_admin}
  let(:project) {create_project}


  describe 'GET #index' do
    it 'renders membership index page for owners' do
      session[:user_id] = user.id
      create_member(project, user, role: 'Owner')
      get :index, project_id: project.id
      expect(response).to render_template(:index)
    end

    it 'redirects visitors to sign in page' do
      get :index, project_id: project.id
      expect(response).to redirect_to(sign_in_path)
    end


    it 'renders membership index page for members' do
      session[:user_id] = user.id
      create_member(project, user)
      get :index, project_id: project.id
      expect(response).to render_template(:index)
    end


    it 'redirects users who are non-members' do
      session[:user_id] = user.id
      get :index, project_id: project.id
      expect(response).to redirect_to(projects_path)
    end


    it 'renders the membership index page for admins' do
      session[:user_id] = admin.id
      get :index, project_id: project.id
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    it 'Project Owner can add new Member to project' do
    session[:user_id] = user.id
    create_member(project, user, role: 'Owner')
    expect {
      post :create, project_id: project.id, membership: {user_id: admin.id, project_id: project.id, role: 'Member'}
    }.to change {Membership.count}.by(1)
    end

    it 'Project Member cannot add new Member' do
    session[:user_id] = user.id
    user2 = create_user
    create_member(project, user, role: 'Member')
    expect {
      post :create, project_id: project.id, membership: {user_id: user2.id, project_id: project.id, role: 'Member'}
    }.to_not change {Membership.count}
    end
  end

  describe 'PUT #update' do
    it 'Project Owner can update a Member' do
      session[:user_id] = user.id
      user2 = create_user
      membership1 = create_member(project, user, role: 'Owner')
      membership2 = create_member(project, user2, role: 'Member')
      expect {
      put :update, project_id: project.id, id: membership2.id, membership: {role: 'Owner'}
      }.to change{membership2.reload.role}
      end
  end

  describe 'DELETE #destroy' do
    it 'Owner can destroy membership' do
      session[:user_id] = user.id
      user2 = create_user
      membership2 = create_member(project, user2, role: 'Owner')
      membership = create_member(project, user, role: 'Owner')
      expect{
      delete :destroy, project_id: project.id, id: membership2.id, membership: {user_id: user2.id, project_id: project.id, role: 'Owner'}
      }. to change { Membership.all.count }.by(-1)
    end
  end
end
