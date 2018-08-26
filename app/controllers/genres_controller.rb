require 'http'

class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  #Fetch data from MovieDB and shove to Genre table
  def get_genre_list 
    @get_genre_list = HTTP.get("https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=a535faacf3a8b1eb413a9dce8ae2ca51").to_s
    @genre_data = JSON.parse(@get_genre_list)

    #Loop through moviedb list and add each genre to Genre model
    for i in 0..@genre_data["genres"].length-1
      current_genre = @genre_data["genres"][i]
      number = current_genre["id"]
      name = current_genre["name"]
      Genre.create ({ "number" => number,
                      "name" => name })
      end
  end

  # GET /genres
  # GET /genres.json
  def index
    if Genre.any? == false 
      get_genre_list()
    end
    @genres = Genre.all
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # GET /genres/1/edit
  def edit
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(genre_params)

    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genres/1
  # PATCH/PUT /genres/1.json
  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }
        format.json { render :show, status: :ok, location: @genre }
      else
        format.html { render :edit }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    @genre.destroy
    respond_to do |format|
      format.html { redirect_to genres_url, notice: 'Genre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_params
      params.require(:genre).permit(:number, :name)
    end
end
