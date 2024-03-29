class Upload < ActiveRecord::Base
	###
	before_create :set_filename
	after_create :store_file
	after_destroy :delete_file

	# restrictions
	validates_presence_of :uploaded_file

	attr_accessor :uploaded_file

	def link
		"/uploads/#{CGI.escape(filename)}"
	end

	###
	private

	def store_file
		File.open(file_storage_location, 'w') do |f|
			f.write uploaded_file.read
		end
	end

	def delete_file
		File.delete(file_storage_location)
	end

	def file_storage_location
		File.join(Rails.root, 'public', 'uploads', filename)
	end

	def set_filename
		self.filename = uploaded_file.original_filename
	end
end
