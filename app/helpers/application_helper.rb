module ApplicationHelper
  
  def portrait_image_url(bioguide_id)
    "//#{ENV['AWS_S3_BUCKET']}.s3.amazonaws.com/portraits/#{bioguide_id}.jpg"
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
  
end
