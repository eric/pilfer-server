class AppsController < ApplicationController
  before_action :fetch_app, only: [:show, :edit, :update, :destroy]

  def index
    @apps = App.all

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @app = App.new

    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to apps_path, notice: 'App created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to apps_path, notice: 'App updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @app.destroy

    respond_to do |format|
      format.html { redirect_to apps_path }
    end
  end

  private

  def fetch_app
    @app = App.find(params[:id])
  end

  def app_params
    params.require(:app).permit(:name)
  end
end
