class RatingsController < ApplicationController
  before_action :skip_if_cached, only: [:index]

  def index
    #Rails.cache.write("beer top 3", Beer.top(3)) if cache_does_not_contain_data_or_it_is_too_old
    @top_beers = Rails.cache.read "beer top 3"
    @ratings = Rating.all
    @recent_ratings = Rating.recent
    @top_breweries = Brewery.top 3
    @top_beers = Beer.top 3
    @top_users = User.top 3
    @top_styles = Style.top 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  def skip_if_cached
    return render :index if fragment_exist?( 'ratings' )
  end
end