
namespace :import do
	
	desc "Import Links from CSV"
	task links: :environment do
		filename = File.join Rails.root, "links.csv"
		counter = 0

		CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
			:name, :reg_url, :src_name, :pfm_name, :opt_identifier
			link = Link.new row.to_hash.slice(:name, :reg_url, :src_name, :pfm_name, :opt_identifier)
				
			if link.save
				counter += 1
			else
				puts "#{name} #{link.errors.full_messages.join(",")}"
			end
		end
		puts "Imported #{counter} links."
	end
end