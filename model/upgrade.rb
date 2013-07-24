# -------------------------------------------------------------------
# Giec Database Upgrade
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Dependencies
require 'rubygems'
require 'data_mapper'
require_relative 'connection.rb'
require_relative 'model.rb'
require_relative 'taxonomies.rb'

# Database Migration
#=====================
puts 'Updating Database...'
DataMapper.auto_upgrade!
puts 'Done !'