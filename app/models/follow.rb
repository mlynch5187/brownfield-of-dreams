class Follow
  attr_reader :login, :html_url

  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def has_account?
    # call API https://api.github.com/users/kristastadler
    # if User.find(API returned email address of follower/following)
    #   true
    # else
    #   false
  # end
  end 
end
