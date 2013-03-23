module ApplicationHelper
  
  def portrait_image_url(bioguide_id)
    "//#{ENV['AWS_S3_BUCKET']}.s3.amazonaws.com/portraits/#{bioguide_id}.jpg"
  end
  
end
