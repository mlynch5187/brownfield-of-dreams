class SearchResult
  def repos(token)
    conn = Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "token #{token}"
    end

    repos = conn.get('/user/repos')
    json = JSON.parse(repos.body, symbolize_names: true)
    @repos = json.map do |github_repos|
      Repo.new(github_repos)
    end
  end

  def followers(token)
    conn = Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "token #{token}"
    end

    follower_list = conn.get('/user/followers')
    json = JSON.parse(follower_list.body, symbolize_names: true)
    @followers = json.map do
      Follow.new(follower_list)
    end
  end

  def following(token)
    conn = Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "token #{token}"
    end

    following_list = conn.get('user/following')
    json = JSON.parse(following_list.body, symbolize_names: true)
    @following = json.map do
      Follow.new(following_list)
    end
  end
end
