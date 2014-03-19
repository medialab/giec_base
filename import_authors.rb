# -------------------------------------------------------------------
# Giec Authors Importer
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# TODO : refacto la gestion des exceptions

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
        @placeholder_institutions = {}
        @institutions = {}
        @authors = {}
        @countries = {}
        @registers = {}
        @departments = {}
        @taxonomy = {}

        # Temporary exclusion
        @exclusion = Taxonomies::Exclusion

        for i in Institution.all(:name => 'N/A')
            @placeholder_institutions.store(i.country.name, i)
        end

        for t in InstitutionType.all
            @taxonomy.store(t.symbol, t)
        end

        for c in Country.all
            @countries.store(c.name, c.id)
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
            aut = {:id => Taxonomies::Duplicates[row[0]] || row[0], :first_name => row[1], :last_name => row[2]}
            ins = {:name => row[8], :type => row[7], :department => row[9], :country => row[10]}

            # Yielding rows
            if row[7] != 'IPCC' && !@exclusion.include?(aut[:id].to_i) then yield ins, aut end
        end
    end

    # Getting institutions
    def compute
        
        # Looping
        load_csv do |ins, aut|

            # Registering institution
            if ins[:type] == "INT" || ins[:type] == "INDV" || ["Russian Federation", "USSR"].include?(ins[:country]) || ins[:name] == "University of the West Indies" || ins[:name] == "Ecofys" || ins[:name] == "Greenpeace International" then ins_key = ins[:name]+'||'+ins[:country] else ins_key = ins[:name] end

            if ins[:name] != "N/A"

                if !@institutions.has_key?(ins_key)
                    model = Institution.new(:name => ins[:name], :country_id => @countries[ins[:country]])
                    @institutions.store(ins_key, model)
                else

                    # Registering country if we find it elsewhere
                    if @institutions[ins_key].country == "N/A" and ins[:country] != "N/A"
                        @institutions[ins_key][:country_id] = @countries[ins[:country]]
                    end
                end

                # Registering Department
                depkey = nil
                if ins[:department] != nil
                    depkey = ins[:department]+'||'+ins[:name]
                    if !@departments.has_key?(depkey)
                        model = Department.new(:name => ins[:department])
                        
                        # Linking to institution
                        @institutions[ins_key].departments << model
                        @departments.store(depkey, model)
                    end
                end

                # Registering Institution Types
                if ins[:type] != 'N/A'
                    @institutions[ins_key].type = @taxonomy[ins[:type]]
                end
            end

            # Registering Author
            if !@authors.has_key?(aut[:id])
                model = Author.new(:id => aut[:id], :first_name => aut[:first_name], :last_name => aut[:last_name])
                @authors.store(aut[:id], model)
                @registers.store(aut[:id], [])
            end

            # Author's Institutions
            if ins[:name] != 'N/A'
                if !@registers[aut[:id]].include?(ins[:name])
                    @registers[aut[:id]].push(ins[:name])
                    @authors[aut[:id]].institutions << @institutions[ins_key]

                    if depkey != nil
                        @authors[aut[:id]].departments << @departments[depkey]
                    end
                end
            else
                @authors[aut[:id]].institutions << @placeholder_institutions[ins[:country]]
            end

        end
    end

    # Saving all this mess
    def save

        Institution.transaction do
            @institutions.each do |x, ins|

                # Registering type
                if ins.type == nil then ins[:type_id] = 12 end
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