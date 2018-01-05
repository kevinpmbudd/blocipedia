class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find_by_id( params[:id] )
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new( wiki_params )
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was successfully created"
      redirect_to @wiki
    else
      flash.now[:alert] = "Wiki creation unsuccessful. Try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find_by_id( params[:id] )
  end

  def update
    @wiki = Wiki.find_by_id( params[:id] )
    @wiki.assign_attributes( wiki_params )

    if @wiki.save
      flash[:notice] = "Wiki updated!"
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving wiki. Try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find_by_id( params[:id] )

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
