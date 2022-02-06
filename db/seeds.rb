access_token = ENV['QIITA_TOKEN']
all_articles = []
resource_url = 'https://qiita.com/api/v2/items'
headers = { 'Authorization' => "Bearer #{access_token}" }
page = 0
10.times do
  page += 1
  params = {
    'page' => page,
    'per_page' => '100'
  }
  url = resource_url + '?' + URI.encode_www_form(params)
  res = URI.open(url, headers)
  articles = JSON.parse(res.read)
  break if articles.empty?
  all_articles.concat articles
end
all_articles.sort_by!{ |hash| hash['likes_count'].to_i }.reverse!

all_articles.each do |article|
  user = User.find_or_create_by!(name: article['user']['id'])
  item = user.items.create!(title: article['title'], url: article['url'], likes_count: article['likes_count'], created_at: article['created_at'])
  if article['tags'].size > 0
    article['tags'].each do |tag|
      item.tags.create!(name: tag['name'])
    end
  end
end
p "#{Time.current}: DB更新処理が完了しました"