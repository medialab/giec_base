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

	# Launching
	def initialize

		# Properties
		puts 'Importing Authors and Institutions...'
		@institutions = {}
		@authors = {}
		@registers = {}
		@departments = {}
		@taxonomy = {}

		for t in InstitutionType.all
			@taxonomy.store(t.symbol, t)
		end

		# Working
		compute
		save

		puts 'Done !'
	end

	# Loading CSV File
	def load_csv
		CSV.foreach("feed/Authors.csv", {:headers => :first_row}) do |row|

			# Users
			aut = {:id => row[0], :first_name => row[1], :last_name => row[2], :groupings => row[16]}

			# Yielding rows
			if row[8] != nil
				if row[7] != 'IPCC'
					ins = {:name => row[8], :type => row[7], :department => row[9], :country => row[10]}
					yield ins, aut
				end
			end
		end
	end

	# Getting institutions
	def compute
		
		# Looping
		load_csv do |ins, aut|

			# Registering institution
			if ins[:name] != nil
				if ins[:name] != "N/A" and ins[:name] != ''
					if !@institutions.has_key?(ins[:name])
						model = Institution.new(:name => ins[:name], :country => ins[:country])
						@institutions.store(ins[:name], model)
					else

						# Registering country if we find it elsewhere
						if @institutions[ins[:name]].country == nil and ins[:country] != nil
							@institutions[ins[:name]].country = ins[:country]
						end
					end

					# Registering Department
					depkey = nil
					if ins[:department] != nil
						depkey = ins[:department]+'||'+ins[:name]
						if !@departments.has_key?(depkey)
							model = Department.new(:name => ins[:department])
							
							# Linking to institution
							@institutions[ins[:name]].departments << model
							@departments.store(depkey, model)
						end
					end

					# Registering Institution Types
					if ins[:type] != nil and ins[:type] != ''
						if @institutions[ins[:name]].type == nil
							@institutions[ins[:name]].type = @taxonomy[ins[:type]]
						end
					end
				end
			end

			# Registering Author
			if !@authors.has_key?(aut[:id])
				model = Author.new(:id => aut[:id], :first_name => aut[:first_name], :last_name => aut[:last_name])
				@authors.store(aut[:id], model)
				@registers.store(aut[:id], [])

				# Groupings
				if aut[:groupings] != nil
					for grouping in aut[:groupings].split('/')
						gpmodel = Grouping.new(:symbol => grouping)
						@authors[aut[:id]].groupings << gpmodel
					end
				end
			end

			# Author's Institutions
			if ins[:name] != nil
				if ins[:name] != '' and ins[:name] != 'N/A'
					if !@registers[aut[:id]].include?(ins[:name])
						@registers[aut[:id]].push(ins[:name])
						@authors[aut[:id]].institutions << @institutions[ins[:name]]

						if depkey != nil
							@authors[aut[:id]].departments << @departments[depkey]
						end
					end
				end
			end

		end
	end

	# Saving all this mess
	def save
		Institution.transaction do
			@institutions.each do |x, ins|
				ins.save
			end
		end
		puts 'Institutions Done !'
		Department.transaction do
			@departments.each do |x, dep|
				dep.save
			end
		end
		puts 'Departments Done !'
		Author.transaction do
			@authors.each do |x, aut|
				aut.save
			end
		end
		puts 'Auhors Done !'
	end
end

Importer.new