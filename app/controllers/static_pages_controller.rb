class StaticPagesController < ApplicationController
  def home
    @movies = Movie.order('release_on ASC')
    @reviews = Review.order('created_at ASC')
  end

  def about
  end
end
