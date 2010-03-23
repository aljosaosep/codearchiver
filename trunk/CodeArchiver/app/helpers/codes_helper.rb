module CodesHelper
  # Returns author's name as string
  # Input: code class
  # Output: name
  def authorName(thisCode)
    return User.find(thisCode.user_id).username
  end
  
  # Returns programLanguage as string
  # Input: code class
  # Output: programLanguage name
  def programLanguageName(thisCode)
    return ProgramLanguage.find(thisCode.program_language_id).language_name
  end
  
  
end
