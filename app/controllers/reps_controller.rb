class RepsController < ApplicationController
  
  def show
    @legislator = Sunlight::Congress.legislator params[:id]
  end
  
end
