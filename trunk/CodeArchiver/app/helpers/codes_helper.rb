module CodesHelper
  # Returns author's name as string
  # Input: code class
  # Output: name
  def authorName(thisCode)
    return User.find(thisCode.user_id).username
  end
end
