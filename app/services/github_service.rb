class GithubService
  def conn(token)
    Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Authorization'] = "token #{token}"
    end
  end

  def repos(token)
    repos = conn(token).get('/user/repos')
    JSON.parse(repos.body, symbolize_names: true)
  end

  def followers(token)
    follower_list = conn(token).get('/user/followers')
    JSON.parse(follower_list.body, symbolize_names: true)
  end

  def following(token)
    following_list = conn(token).get('user/following')
    JSON.parse(following_list.body, symbolize_names: true)
  end
end
