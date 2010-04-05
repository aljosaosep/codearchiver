class Code < ActiveRecord::Base
  validates_presence_of :code_body
  validates_presence_of :title
  validates_length_of :title, :maximum=>40
  validates_presence_of :description
  validates_presence_of :shortdescription
  validates_length_of :shortdescription, :maximum=>50, :message=>": Maximum 50 character allowed"
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
		return Category.find(self.user_id).name
	end

  	# Returns programLanguage as string
  	# Output: programLanguage name
	def getProgLangName
		return ProgramLanguage.find(self.user_id).language_name
	end

  	# Returns Type as string
  	# Output: Type name
	def getTypeName
		return Type.find(self.user_id).name
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
		return Category.find(self.user_id)
	end

  	# Returns programLanguage obj
  	# Output: obj
	def getProgLang
		return ProgramLanguage.find(self.user_id)
	end

  	# Returns Type obj
  	# Output: obj
	def getType
		return Type.find(self.user_id)
	end
end
