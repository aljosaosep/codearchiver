class Code < ActiveRecord::Base
	attr_accessible :title

  	validates_presence_of :code_body
  	validates_presence_of :title
  	validates_length_of :title, :maximum=>40
  	validates_presence_of :description
  	validates_presence_of :shortdescription
  	validates_length_of :shortdescription, :maximum=>200, :message=>": Maximum 200 character allowed"
  	validates_presence_of :user_id
  	validates_presence_of :category_id
  	validates_presence_of :type_id
  
  	belongs_to :user
  	belongs_to :program_language
  	belongs_to :category
  	belongs_to :type
  
  	# Added by Edo, 23.3.2010
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
    puts "self iD =============" + self.id.to_s
    @gradeTemp = Grade.find(:all, :conditions => {:code_id => self.id})
    @sum = 0
    for gradeX in @gradeTemp
      @sum+=gradeX.value
    end
    puts "VSOTTTTAAAA = "+ @sum.to_s
    return @sum
  end
end
