module Api
  module V1
     class AirlinesController < ApplicationController
    def index
      airlines = Airline.all 
    end
  end
end