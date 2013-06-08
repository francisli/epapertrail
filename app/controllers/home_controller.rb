class HomeController < ApplicationController
  
  def index
    
  end
  
  def reps
    # fetch reps, if not set session
    session[:reps] = Sunlight::Congress.legislators_locate(session[:location][:lat], session[:location][:lng]) if session[:reps].blank?
    # fetch reps and speeches for specified chamber
    @reps = []
    @speeches = []
    session[:reps]['results'].each do |rep|
      if rep['chamber'] == params[:chamber]
        @reps << rep
        @speeches << Sunlight::CapitalWords.latest_speech(rep['bioguide_id'])
      end
    end
    render :partial => 'reps'
  end
  
  def votes
    response = Sunlight::Congress.latest_vote(params[:chamber])
    @vote = response['results'].first
    render :partial => 'votes'
  end
  
  def compare
    # pick a chamber
    chamber = ['house', 'senate'].sample
    # pick two currently serving members from different parties
    response = Sunlight::Congress.legislators_in_office(chamber)
    parties = { 'R' => [], 'D' => [], 'I' => [] }
    response['results'].each do |legislator|
      parties[legislator['party']] << legislator
    end
    @legislator1 = response['results'].sample
    parties.delete(@legislator1['party'])
    legislators = []
    parties.each do |k, v|
      legislators += v
    end
    @legislator2 = legislators.sample
    # get vote history
    response = Sunlight::Congress.votes_with_legislators(@legislator1['bioguide_id'], @legislator2['bioguide_id'])
    @counts = { :agreed => 0, :total => 0 }
    @votes_against = { @legislator1['bioguide_id'] => 0, @legislator2['bioguide_id'] => 0 }
    response['results'].each do |result|
      vote1 = result['voter_ids'][@legislator1['bioguide_id']]
      vote2 = result['voter_ids'][@legislator2['bioguide_id']]
      if vote1 != 'Not Voting' and vote2 != 'Not Voting'
        @counts[:agreed] += 1 if vote1 == vote2
        @counts[:total] += 1
      end
      party_vote1 = result['breakdown']['party'][@legislator1['party']].max_by{|vote, count| count}.first
      party_vote2 = result['breakdown']['party'][@legislator2['party']].max_by{|vote, count| count}.first
      @votes_against[@legislator1['bioguide_id']] += 1 if vote1 != party_vote1
      @votes_against[@legislator2['bioguide_id']] += 1 if vote2 != party_vote2
    end
    @counts[:similarity] = @counts[:agreed]*100/@counts[:total]
    # get bill sponsorship stats
    response = Sunlight::Congress.bills_cosponsored(@legislator1['bioguide_id'], @legislator2['bioguide_id'])
    @counts[:cosponsored] = response['count']
    # 
    render :partial => 'compare'
  end
  
end
