module Public::ArticlesHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/tags/#{word.delete("#")}",data: {"turbolinks" => false} }.html_safe
  end

  def new_line(content)  #改行するため
    safe_join(content.split("\n"),tag(:br))
  end
end
