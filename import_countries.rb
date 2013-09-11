# -------------------------------------------------------------------
# Giec Countries Importer
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
        puts 'Importing Countries...'
        @countries = []
        @placeholder_institutions = []
        @groupings = []
        @count = 0

        # Working
        compute
        save

        puts 'Done !'
    end

    # Getting institutions
    def compute
        
        # Computing countries
        for country in Taxonomies::Countries
            country_model = Country.new(:name => country[:name])

            # Groupings
            for grouping in country[:groupings].split('/')
                grouping_model = Grouping.new(:symbol => grouping)
                country_model.groupings << grouping_model

                @groupings.push grouping_model
            end

            @countries.push country_model
        end

        # Computing placeholder institutions
        for country in @countries
            @placeholder_institutions.push Institution.new(:name => 'N/A', :type_id => 10, :country => country)
        end
    end

    # Saving all this mess
    def save
        Country.transaction do
            @countries.each do |country|
                country.save
            end
        end
        Grouping.transaction do
            @groupings.each do |grouping|
                grouping.save
            end
        end
        Institution.transaction do
            @placeholder_institutions.each do |ins|
                ins.save
            end
        end
    end
end

Importer.new