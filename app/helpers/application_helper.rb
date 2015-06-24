module ApplicationHelper
  
  def portrait_image_url(bioguide_id)
    "http://theunitedstates.io/images/congress/225x275/#{bioguide_id}.jpg"
  end
  
  def similarity_label(percentage)
    if percentage > 90
      I18n.t 'helpers.similarity_label.high'
    elsif percentage > 80
      I18n.t 'helpers.similarity_label.medium'
    elsif percentage > 70
      I18n.t 'helpers.similarity_label.low'
    elsif percentage > 50
      I18n.t 'helpers.similarity_label.even'
    else
      I18n.t 'helpers.similarity_label.none'
    end
  end
  
  def friendly_bill_id(bill_id)
    match = bill_id.match /([^0-9]+)([0-9]+)/
    "#{match[1].upcase.chars.join('.')}. #{match[2]}"
  end
  
  def rep_link(rep_id, rep, party = nil)
    link_to "#{rep['first_name']} #{rep['middle_name']} #{rep['last_name']}", rep_path(rep_id), class: 'rep-link'
  end
  
end
