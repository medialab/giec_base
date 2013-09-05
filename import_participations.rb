# -------------------------------------------------------------------
# Giec Institutions Importer
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Dependencies
require 'rubygems'
require 'data_mapper'
require_relative 'model/connection.rb'
require_relative 'model/model.rb'
require_relative 'model/taxonomies.rb'

class Importer

	# Launcing
	def initialize

		# Properties
		puts 'Importing Participations...'
		@AR = nil
		@max_ar = 4
		@header = []
		@participations = []
		@authors = {}

		# Getting authors
		for a in Author.all
			@authors.store(a.id, a)
		end

		# Process
		compute
		save
		puts 'Done !'
	end

	# Loading Csv File
	def load_csv(csv, ar)
		@AR = ar
		CSV.foreach(csv) do |row|

			# Reading Header
			if $. == 1 
				@header = row
			else

				# Yielding row
				agregate = {:id => row[0], :links => []}
				row[1..-1].each_with_index do |val, index|
					if val != nil then agregate[:links].push({:chapter => @header[index+1].strip, :role => val.strip}) end
				end
				yield agregate
			end
		end
	end

	# Computing model
	def compute

		for i in 1..@max_ar
			puts "Importing AR #{i}..."
			load_csv("feed/AR#{i}.csv", i) do |p|

				# Looping through participations
				for c in p[:links]
					pos = c[:chapter].split('.')
					model = Participation.new(:ar => @AR, :wg => pos[0], :chapter => pos[1], :role => c[:role], :author => @authors[p[:id].to_i])
					@participations.push(model)
				end
			end
		end
		
	end

	# Saving to DB
	def save
		Participation.transaction do
			@participations.each do |p, x|
				p.save
			end
		end
	end
end

Importer.new