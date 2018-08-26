require 'date'

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  #Fetch data from MovieDB and shove to Movie table
  def get_movie_list
    @get_moviedb_list = HTTP.get("https://api.themoviedb.org/3/movie/top_rated?api_key=a535faacf3a8b1eb413a9dce8ae2ca51").to_s
    @moviedb_data = JSON.parse(@get_moviedb_list)
    
    #Loop through moviedb list and add each movie to Movie model
    for i in 0..1
      current_movie = @moviedb_data["results"][i]
      title = current_movie["title"]
      release_date = current_movie["release_date"]
      poster = "https://image.tmdb.org/t/p/w600_and_h900_bestv2" + current_movie["poster_path"]
      @genre_array = Array.new
      
      #Add genre ids to an array to link up with movie later
      if current_movie["genre_ids"].length > 1
        for i in 0..current_movie["genre_ids"].length-1
          @genre_array.push(current_movie["genre_ids"][i])
        end
      else
        @genre_array.push(current_movie["genre_ids"][0])
      end
      
      #create movie time
      @new_movie = Movie.create ({ "title" => title, 
                                "release_on" => release_date,
                                "poster" => poster })
      
      #Linking movie with genres here
      for j in 0..@genre_array.length-1
          @temp = @genres.where(number: @genre_array[j]).take! #grab that genre with matching number
          @new_movie.genres << @temp #TA-DAH! link that genre to movie #railsmagic
      end
    end
  end

  # GET /movies
  # GET /movies.json

  def index
    @genres = Genre.all
    @movies = Movie.all
    #if Movie table is empty, then fetch data from moviedb
    if Movie.any? == false 
      get_movie_list()
    end
 
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save        
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :release_on, :poster)
    end
end
