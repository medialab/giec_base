# -------------------------------------------------------------------
# Countries Evolution
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

require_relative 'subqueries/ar_participation.rb'

class Query

	# Properties
	def initialize
		@csv_header = ['country', 'ar2_nb', 'ar2_percent', 'ar3_nb', 'ar3_percent', 'ar4_nb', 'ar4_percent']
		@ars = (2..4).to_a
		@countries = {}
		@total_participations = TotalParticipation.get

		# Getting countries
		distinct_countries = repository(:default).adapter.select('SELECT DISTINCT country from institutions ORDER BY country')
		distinct_countries.map {|c| @countries.store(c, {})}
	end

	# Query Execution
	def exec

		# Looping through countries
		@countries.each_key do |country|

			# Looping through ar
			for ar in @ars

				# Looping through participations
				@countries[country].store(ar, Participation.count('institution.country' => country, 'ar' => ar))
			end
		end

		return csv_output
	end

	# CSV Ouptut
	def csv_output
		csv_array = [@csv_header]
		@countries.each do |country, counts|
			csv_array.push([
				country,
				counts[2],
				(counts[2] * 100) / @total_participations[2],
				counts[3],
				(counts[3] * 100) / @total_participations[3],
				counts[4],
				(counts[4] * 100) / @total_participations[4]
			])
		end
		return csv_array
	end
end