require "rails_helper"


describe TasksController do

  let(:user) {create_user}
  let(:project) {create_project}
  let(:task) {create_task}


  describe 'GET #index' do
    describe 'Permissions' do
      it 'Non-project member cannot access tasks index' do
        session[:user_id] = user.id
        get :index, project_id: project.id
        expect(response).to redirect_to projects_path
      end
      it 'should let a member acess tasks index' do
        create_member(project, user)
        session[:user_id] = user.id
        get :index, project_id: project.id
        expect(response).to render_template :index
      end
    end
  end
end
