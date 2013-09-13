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
			if i.country != nil
				key = i.name+'||'+i.country.name.to_s
			else
				key = i.name
			end
			@institutions.store(key, i)
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
			agregate = {:ar => row[5], :author_id => row[0], :institution => row[8], :department => row[9], :country => row[10]}
			yield agregate
		end
	end

	# Computing model
	def compute
		Participation.transaction do
			load_csv do |p|

				if p[:institution] != nil && p[:country] != nil
				
					# Special cases
					if p[:institution] == nil && p[:country] != nil
						p[:institution] = "N/A"
					end

					# Looping through authors
					Participation.all(:ar => p[:ar], :author_id => p[:author_id]).update(:institution => @institutions[p[:institution]+'||'+p[:country]], :department => @departments[p[:department]])
				end
			end
		end

	end
end

Importer.new