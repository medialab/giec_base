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

        @exclusion = Taxonomies::Exclusion

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
        CSV.foreach("feed/Authors.csv", {:headers => :first_row}) do |row|

            # Reading csv
            agregate = {:ar => row[5], :author_id => row[0], :institution => row[8], :department => row[9], :country => row[10], :type => row[7]}

            if agregate[:type] != 'IPCC' && !@exclusion.include?(agregate[:author_id].to_i) then yield agregate end
        end
    end

    # Computing model
    def compute
        Participation.transaction do
            load_csv do |p|
                
                dep_id = p[:department] != nil ? @departments[p[:department]].id : nil
                ins_id = Institution.first(:name => p[:institution], 'country.name' => p[:country]).id

                Participation.all(:ar => p[:ar], :author_id => p[:author_id]).update(:institution_id => ins_id, :department_id => dep_id)
            end
        end
    end
end

Importer.new