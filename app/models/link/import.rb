class Link::Import
	include ActiveModel::Model
	attr_accessor :file, :imported_count

	def process!
		@imported_count = 0
		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			
			link = Link.new row.to_hash.slice(:name, :reg_url, :src_name, :pfm_name, :opt_identifier)
				
			if link.save
				@imported_count += 1
			else
				errors.add :base, "Line #{$.} - #{link.errors.full_messages.join(",")}"
				
			end
		end
	end

	def save
		process!
		errors.none?
	end
end