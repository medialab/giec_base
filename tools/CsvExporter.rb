# -------------------------------------------------------------------
# Csv Exporter
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

class Exporter

	# Main Static Method
	def self.save(csv_array, filepath)
		CSV.open(filepath, 'w') do |csv|
			for row in csv_array
				csv << row
			end
		end
	end
end