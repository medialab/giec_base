# -------------------------------------------------------------------
# Giec Chairmen Importer
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
		puts 'Importing Chairmen...'
		@chairmen = {}
		@offices = []

		# Working
		compute
		save

		puts 'Done !'
	end

	# Loading CSV File
	def load_csv
		CSV.foreach("feed/Chairmen.csv", {:headers => :first_row}) do |row|
			author = {:first_name => row[0], :last_name => row[1]}
			chairman = {:role => row[2], :rank => row[3], :ar => row[4], :wg => row[5]}
			yield author, chairman
		end
	end

	# Getting institutions
	def compute
		
		# Looping
		load_csv do |author, chairman|
			
			# Finding equivalent author
			relevant_author = Author.first(author)
			co = ChairmanOffice.new(chairman)
			
			# New Author
			if relevant_author == nil
				key = author[:first_name]+'|'+author[:last_name]
				if !@chairmen.has_key? key
					@chairmen.store(key, Author.new(author))
					co.author = @chairmen[key]
					@offices.push(co)
				end
			else
				co = ChairmanOffice.new(chairman)
				co.author = relevant_author
				co.institution = relevant_author.institutions[0]
				co.department = relevant_author.departments[0]
				@offices.push(co)
			end
		end
	end

	# Save
	def save
		Author.transaction do 
			@chairmen.each_value do |c|
				c.save
			end
		end

		ChairmanOffice.transaction do 
			@offices.each do |o|
				o.save
			end
		end
	end
end

Importer.new
