# -------------------------------------------------------------------
# Giec Regularization
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
        puts 'Regularization...'

        # Process
        compute
        puts 'Done !'
    end

    # Computing model
    def compute

    end
end

Importer.new