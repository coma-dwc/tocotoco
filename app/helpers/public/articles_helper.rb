module Public::ArticlesHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/tags/#{word.delete("#")}",data: {"turbolinks" => false} }.html_safe
  end
end
