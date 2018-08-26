class StaticPagesController < ApplicationController
  def home
    @movies = Movie.all
  end

  def about
  end
end
