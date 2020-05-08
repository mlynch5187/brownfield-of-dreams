class SearchResult
  def repos(token)
    json = GithubService.new.repos(token)
    @repos = json.map do |github_repos|
      Repo.new(github_repos)
    end
  end

  def followers(token)
    json = GithubService.new.followers(token)
    @followers = json.map do |follower_list|
      Follow.new(follower_list)
    end
  end

  def following(token)
    json = GithubService.new.following(token)
    @following = json.map do |following_list|
      Follow.new(following_list)
    end
  end
end
