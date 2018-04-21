class MoviesController < ApplicationController
  def index
    @movies, @target = 
      if params[:sort_by]
        [Movie.order(params[:sort_by]), params[:field_id]]
      else 
        [Movie.all, nil]
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
      render :new
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

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

end
