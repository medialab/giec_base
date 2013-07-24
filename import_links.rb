# -------------------------------------------------------------------
# Giec Link Importer
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
		puts 'Importing Links...'
		@authors = {}
		@institutions = {}
		@departments = {}

		# Getting institutions
		for i in Institution.all
			@institutions.store(i.name, i)
		end

		# Getting departments
		for d in Department.all
			@departments.store(d.name, d)
		end

		# Process
		compute
		puts 'Done !'
	end

	# Loading Csv File
	def load_csv
		CSV.foreach("feed/Authors.csv") do |row|

			# Reading csv
			if row[8] != nil
				agregate = {:ar => row[5], :author_id => row[0], :institution => row[8], :department => row[9]}
				yield agregate
			end
		end
	end

	# Computing model
	def compute
		Participation.transaction do
			load_csv do |p|

				# Looping through authors
				Participation.all(:ar => p[:ar], :author_id => p[:author_id]).update(:institution => @institutions[p[:institution]], :department => @departments[p[:department]])
				
			end
		end

	end
end

Importer.new