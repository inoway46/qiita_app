module ApplicationHelper
  def show_jp_date(date)
    date.strftime("%Y年%m月%d日")
  end

  def search_word_presend?
    return true if params[:q]
  end
end
