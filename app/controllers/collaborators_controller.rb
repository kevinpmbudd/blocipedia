class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def create
    @wiki = Wiki.find( params[:wiki_id] )

    if params[:user_ids].present?
      @users = User.find(params[:user_ids] )
      @wiki.users = @users
    else
      @wiki.users.clear
    end

    redirect_to @wiki
  end
end
