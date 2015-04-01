require "rails_helper"


  describe MembershipsController do

    let(:user) {create_user}
    let(:admin) {create_admin}
    let(:project) {create_project}


      describe "permissions" do
        describe 'GET #index' do
          describe 'have a logged in user' do
            it 'renders membership index page'
            session[:user_id] = user.id
            create_member(project, user, role: 'owner')

            get :index, project_id: project.id
            expect(response).to render_template(:index)
          end
        end
      end
    end
