class Link < ApplicationRecord
	
	def self.import(file)
		counter = 0

		CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
			
			link = Link.new row.to_hash.slice(:name, :reg_url, :src_name, :pfm_name, :opt_identifier)
				
			if link.save
				counter += 1
			else
				puts "#{name} #{link.errors.full_messages.join(",")}"
			end
		end
		counter
		
	end

	def self.to_csv
		attributes = %w{name reg_url src_name pfm_name opt_identifier final_url}
		CSV.generate(headers: true) do |csv|
			csv << attributes

			all.each do |link|
				csv << link.attributes.values_at(*attributes)
			end
		end
	end

	def final_url(reg_url,src_name,pfm_name,opt_identifier)
		
		url = "#{self.reg_url}?aff=#{self.src_name}#{self.pfm_name}#{self.opt_identifier}"
		
	end
end


