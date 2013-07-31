# -------------------------------------------------------------------
# Authors in more than one WG
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

class Query

	# Properties
	def initialize
		@csv_header = ['ar','first_name', 'last_name', 'working_groups']
		@ars = (2..4).to_a
		@cross_authors = {}
		@ars.each {|ar| @cross_authors.store(ar, [])}
	end

	# Query Execution
	def exec

		# Looping on ars
		for ar in @ars
			for author in Author.all('participations.ar' => ar)

				# Checking for participations
				wgs = Set.new
				author.data = Set.new
				for p in Participation.all(:author_id => author.id)
					wgs.add(p.wg)
					author.data.add(p.wg)
				end
				author.data = author.data.to_a
				author.data = author.data.sort_by {|x| x}

				# Registering cross authors
				if wgs.length > 1 then @cross_authors[ar].push(author) end
			end
		end

		return csv_output
	end

	# CSV Ouptut
	def csv_output
		csv_array = [@csv_header]

		for ar in @ars
			for author in @cross_authors[ar]
				csv_array.push([
					ar,
					author.first_name,
					author.last_name,
					author.data.join('/')
				])
			end
		end
		return csv_array
	end
end