# -------------------------------------------------------------------
# Giec Authors Deduplication Helper
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
        index = {}
        CSV.foreach("feed/Duplicates.csv", {:headers => :first_row}) do |row|
            index[row[1]]= row[0]
        end

        puts index
    end
end

Updater.new
