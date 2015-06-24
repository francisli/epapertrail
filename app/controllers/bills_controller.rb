class BillsController < ApplicationController

  def show
    @bill = Sunlight::Congress.bill(params[:id])['results'].first
    @vote = Sunlight::Congress.vote_by_bill(params[:id])['results'].first
  end
  
  def summary
    @bill = Sunlight::Congress.bill_summary(params[:id])['results'].first
    render partial: 'summary'
  end

end
