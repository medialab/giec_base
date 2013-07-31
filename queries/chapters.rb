# -------------------------------------------------------------------
# Chapter Query
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

class Query

	# Properties
	def initialize
		@key = "%s.%s"
		@csv_header = ['ar', 'wg', 'chapter', 'authors', 'title']
		@chapters = {}
		(1..5).each {|ar| @chapters.store(ar, {})}

		for c in Chapter.all
			@chapters[c.assessment_report.id].store(@key % [c.working_group.number, c.number], {:model => c, :count => 0})
		end
	end

	# Query Execution
	def exec

		# For each participation
		for p in Participation.all
			index = @key % [p.wg, p.chapter]
			if @chapters[p.ar].has_key?(index)
				@chapters[p.ar][index][:count] += 1
			end
		end

		@chapters.each_key do |ar|
			@chapters[ar] = @chapters[ar].sort_by {|_, value| -value[:count]}
		end

		return csv_output(@chapters)
	end

	# CSV Ouptut
	def csv_output(data)
		
		# Formatting the array
		csv_array = [@csv_header]
		data.each do |ar, chapters|
			for chapter  in chapters
				cinfo = chapter[0].split('.')
				csv_array.push([ar, cinfo[0], cinfo[1], chapter[1][:count], chapter[1][:model].title])
			end
		end

		return csv_array
	end
end