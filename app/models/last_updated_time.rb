class LastUpdatedTime 
	include ActiveModel::SerializerSupport

	def initialize
		@updated_at = Time.now.utc
	end
	
	def updated_at
		@updated_at
	end

	def updated_at=(updated_at)
		@updated_at = updated_at
	end
end
