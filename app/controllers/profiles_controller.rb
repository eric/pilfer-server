class ProfilesController < ApplicationController
  before_filter :fetch_app

  helper_method :profile_value_for_sort

  def index
    @profiles = @app.profiles

    respond_to do |format|
      format.html
    end
  end

  def show
    @profile = @app.profiles.find(params[:id])

    @mode    = params[:mode]
    @minimum = (params[:minimum] || 5).to_i * 1000
    @sort    = params[:sort]
    @summary = params[:summary]

    @sorted_profile = sorted_profile(@profile, @sort, @summary)

    respond_to do |format|
      format.html
    end
  end

  def destroy
    @profile = @app.profiles.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
    end
  end

  private
  def fetch_app
    @app = App.find(params[:app_id])
  end

  def profile_value_for_sort(file_profile, sort, summary)
    if summary == 'exclusive'
      if sort == 'idle'
        idle = file_profile['exclusive'] - file_profile['exclusive_cpu']
        idle = 0 if idle < 0
      elsif sort == 'cpu'
        cpu = file_profile['exclusive_cpu']
      else
        wall = file_profile['exclusive']
      end
    else
      if sort == 'idle'
        idle = file_profile['total'] - file_profile['total_cpu']
        idle = 0 if idle < 0
      elsif sort == 'cpu'
        cpu = file_profile['total_cpu']
      else
        wall = file_profile['total']
      end
    end
  end

  def sorted_profile(profile, sort, summary)
    profile.payload['files'].sort_by do |filename, file_profile|
      profile_value_for_sort(file_profile, sort, summary)
    end.reverse
  end
end
