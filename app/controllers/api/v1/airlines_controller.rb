module Api
  module V1
    class AirlinesController < ApplicationController
      protect_from_forgery with: :null_session

      # GET /api/v1/airlines
      def index
        render json: airlines
      end
      
      # GET /api/v1/airlines/:slug
      def show
        render json: airline
      end

      # POST /api/v1/airlines
      def create
        airline = Airline.new(airline_params)

        if airline.save
          render json: airline.to_json(:include => :reviews)
        else
          render json: errors(airline), status: 422
        end
      end

      # PATCH /api/v1/airlines/:slug
      def update
        airline = Airline.find_by(slug: params[:slug])
        if airline.update(airline_params)
          render json: airline.to_json(:include => :reviews)
        else
          render json: errors(airline), status: 422
        end
      end

      # DELETE /api/v1/airlines/:slug
      def destroy
        begin
          airline = Airline.find_by(slug: params[:slug])
          if airline.destroy
            render json: {message: "Destroyed Successfully"}
          else
            render json: errors(airline), status: 422
          end
        rescue Exception => e
          render json: {message: "Record Was not deleted"}
        end
      end

      private

      # Get all airlines
      def airlines
        Airline.all.to_json(:include => :reviews)
      end

      # Get a specific airline
      def airline
        Airline.find_by(slug: params[:slug]).to_json(:include => :reviews)
      end

      # Strong params
      def airline_params
        params.require(:airline).permit(:name, :image_url)
      end

      # Errors
      def errors(record)
        { errors: record.errors.messages }
      end

      def airline_and_reviews(airlines)
        {
          records:
            airlines.map do |airline|
              {
                Airline: airline,
                reviews: 
                  airline.reviews.map do |review|
                      review
                  end
              }
            end
        }
      end
    end
  end
end