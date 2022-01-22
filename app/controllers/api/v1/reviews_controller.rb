module Api
  module V1
    class ReviewsController < ApplicationController
      protect_from_forgery with: :null_session


      def index
      end
      # POST /api/v1/reviews
      def create
        review = Review.new(review_params)

        if review.save
          render json: review
        else
          render json: errors(review), status: 422
        end
      end

      # DELETE /api/v1/reviews/:id
      def destroy
        begin
          review = Review.find(params[:id])

          if review.destroy
            render json: {message: "Destroyed Successfully"}
          else
            render json: errors(review), status: 422
          end
        rescue Exception => e
          render json: e
        end
      end

      private

      # Strong params
      def review_params
        params.require(:review).permit(:title, :description, :score, :airline_id)
      end

      def errors(record)
        { errors: record.errors.messages }
      end
    end
  end
end