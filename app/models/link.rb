class Link < ApplicationRecord
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


