class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end


  def new
    @movie = Movie.new
  end

  def create
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date)
  end
end
