# -------------------------------------------------------------------
# Chapter Query
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
		@key = "%s.%s"
		@csv_header = ['ar', 'wg', 'chapter', 'nb_authors', 'percentage_authors', 'title', 'code_type','type']
		@chapters = {}
		@total_participations = TotalParticipation.get
		(1..5).each {|ar| @chapters.store(ar, {})}

		# Getting chapters
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

		return csv_output
	end

	# CSV Ouptut
	def csv_output
		
		# Formatting the array
		csv_array = [@csv_header]
		@chapters.each do |ar, chapters|
			for chapter  in chapters
				cinfo = chapter[0].split('.')
				csv_array.push([
					ar, 
					cinfo[0], 
					cinfo[1], 
					chapter[1][:count],
					(chapter[1][:count] * 100) / @total_participations[ar],
					chapter[1][:model].title,
					chapter[1][:model].types.map {|t| t.symbol}.join('/'),
					chapter[1][:model].types.map {|t| t.name}.join(' / ')
				])
			end
		end

		return csv_array
	end
end