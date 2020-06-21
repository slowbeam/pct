require 'award'

def update_quality(awards)
  eligible_awards = awards.reject { |award| award.name == Award::BLUE_DISTINCTION_PLUS }
  eligible_awards.each do |award|
    award.calculate_quality
    award.calculate_expiration
  end
end
