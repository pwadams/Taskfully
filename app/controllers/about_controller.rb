class AboutController < ApplicationController
  def index

      @projects = Project.all
      @tasks = Task.all
      @project_memberships = Membership.all
      @users = User.all
  end
end
