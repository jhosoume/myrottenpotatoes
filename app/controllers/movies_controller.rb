class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order :title
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings]
    @movies = 
      if ((not @selected_ratings) || @selected_ratings.keys.include?("all"))
        Movie.all
      else
        Movie.where rating: @selected_ratings.keys
      end
    @selected_ratings ||= ["all"]
    @movies, @target = 
      if params[:sort_by]
        [@movies.order(params[:sort_by]), params[:field_id]]
      elsif session[:sort_by]
        [@movies.order(session[:sort_by]), session[:field_id]]
      else 
        [@movies.all, nil]
      end

    if (params[:field_id] != session[:field_id]) || (params[:sort_by] != session[:sort_by])
      session[:sort_by], session[:field_id] = params[:sort_by], params[:field_id]
    end

    if (params[:ratings] != session[:ratings])
      session[:ratings] = @selected_ratings
    end

  end

  def show
    @movie = Movie.find params[:id]
  end


  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      flash[:notice] = "#{@movie.title} could not be created."
      redirect_to movies_path
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update 
    @movie = Movie.find params[:id]
    if @movie.update(movie_params)
      flash[:notice] = "#{@movie.title} was successfullly updated!"
      redirect_to movie_path(@movie)
    end
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' was deleted"
    redirect_to movies_path
  end

  def search_tmdb
    flash[:warning] = "#{params[:search_terms]} was not found in TMDb."
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end


end
