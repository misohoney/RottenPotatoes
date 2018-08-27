class StaticPagesController < ApplicationController
  def home
    @movies = Movie.all
    @reviews = Review.all
  end

  def about
  end
end
