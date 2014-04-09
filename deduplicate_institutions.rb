# -------------------------------------------------------------------
# Giec Institution Deduplication
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

class Updater

    def initialize
        puts 'Deduplicating institutions...'

        load_csv &method(:updateSingleInstitution)

        puts 'Done !'
    end

    def load_csv
        CSV.foreach("feed/InstitutionDuplicates.csv", {:headers => :first_row}) do |row|
            yield({:good => row[0], :bad => row[1]})
        end
    end

    def updateSingleInstitution(ids)

        # Departments
        repository(:default).adapter.select("UPDATE departments SET institution_id = #{ids[:good]} WHERE institution_id = #{ids[:bad]}")

        # Authors
        begin
            repository(:default).adapter.select("UPDATE author_institutions SET institution_id = #{ids[:good]} WHERE institution_id = #{ids[:bad]}")
        rescue
            repository(:default).adapter.select("DELETE from author_institutions WHERE institution_id = #{ids[:bad]}")
        end

        # Participations
        repository(:default).adapter.select("UPDATE participations SET institution_id = #{ids[:good]} WHERE institution_id = #{ids[:bad]}")

        # Chairman offices
        repository(:default).adapter.select("UPDATE chairman_offices SET institution_id = #{ids[:good]} WHERE institution_id = #{ids[:bad]}")

        # Deleting the ugly institution
        repository(:default).adapter.select("DELETE from institutions WHERE id = #{ids[:bad]}")
    end
end

Updater.new
