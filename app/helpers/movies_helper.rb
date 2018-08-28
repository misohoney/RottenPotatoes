module MoviesHelper
    def movieRating(reviews)
        @sum = 0;
        if reviews.length > 0
            reviews.each do |review|
                @sum += review.rating
            end     
        end
        avgRating = @sum/reviews.length
        return "score" + avgRating.to_s + ".png"
    end

    def reviewRating(review)
        return "score" + review.rating.to_s + ".png"
    end

    def show_test
        render :partial=>"test"
     end



end
