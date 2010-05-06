class Code < ActiveRecord::Base
  validates_presence_of :code_body
  validates_presence_of :title
  validates_length_of :title, :maximum=>40
  validates_presence_of :description
  validates_presence_of :shortdescription
  validates_length_of :shortdescription, :maximum=>200, :message=>": Maximum 200 character allowed"
  
  belongs_to :user
  belongs_to :program_language
  belongs_to :category
  belongs_to :type
  
  has_many :grades
  has_one :code_replies
  has_many :comments

	##########################################
	# Obj's name getter methods
	# Aljosa 5.4.10
	##########################################

  	# Returns author's name as string
  	# Output: name
	def getAuthorName
		return User.find(self.user_id).username
	end

   	# Returns Category as string
  	# Output: Category name
	def getCategoryName
		return Category.find(self.category_id).name
	end

  	# Returns programLanguage as string
  	# Output: programLanguage name
	def getProgLangName
		return ProgramLanguage.find(self.program_language_id).language_name
	end

  	# Returns Type as string
  	# Output: Type name
	def getTypeName
		return Type.find(self.type_id).name
	end

	##########################################
	# Object getter methods
	# Aljosa 5.4.10
	##########################################

  	# Returns author obj
  	# Output: obj
	def getAuthor
		return User.find(self.user_id)
	end

   	# Returns Category obj
  	# Output: obj
	def getCategory
		return Category.find(self.category_id)
	end

  	# Returns programLanguage obj
  	# Output: obj
	def getProgLang
		return ProgramLanguage.find(self.program_language_id)
	end

  	# Returns Type obj
  	# Output: obj
	def getType
		return Type.find(self.type_id)
	end

	##########################################
	# Etc
	# Aljosa 11.4.10
	##########################################
	
	# Returns all this code comments
	def getComments
		return Comment.find(:all, :conditions => {:code_id => self.id})
	end

  ##########################################
  # Returning the sum(grades) for code
  # 
  ##########################################
  def getSumGrades
    @gradeTemp = Grade.find(:all, :conditions => {:code_id => self.id})
    @sum = 0
    for gradeX in @gradeTemp
      @sum+=gradeX.value
    end
    return @sum
  end
  
  #define_index do
  #  indexes title
  #  indexes shortdescription
  #  indexes description
  #  indexes tag
  #  has user_id
  #end


##########################################
  # Returning the number of comments Edo 06.05.2010
  # 
  ##########################################
  def getNumComments
    return Comment.find(:all, :conditions => {:code_id => self.id}).length
  end

end


