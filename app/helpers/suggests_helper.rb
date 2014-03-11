module SuggestsHelper
  def suggestsNotShown
    if  Suggest.where("shown = 'false'").count.to_i > 0
      '(' + Suggest.where("shown = 'false'").count.to_s + ')'
    else
      ''
    end
  end

end
