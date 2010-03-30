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
  
   # Returns Category as string
  # Input: code class
  # Output: Category name
  def categoryName(thisCode)
    return Category.find(thisCode.category_id).name
  end
  
  # Returns Type as string
  # Input: code class
  # Output: Type name
  def typeName(thisCode)
    return Type.find(thisCode.type_id).name
  end
  
  
  
end
