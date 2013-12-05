# -------------------------------------------------------------------
# SQL to Neography Migration
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Dependencies
require 'rubygems'
require 'data_mapper'
require 'neography'
require_relative 'model/connection.rb'
require_relative 'model/model.rb'
require_relative 'model/taxonomies.rb'

Neography.configure do |config|
  config.protocol       = 'http://'
  config.server         = 'localhost'
  config.port           = 7474
  config.directory      = ''  # prefix this path with '/'
  config.cypher_path    = '/cypher'
  config.gremlin_path   = '/ext/GremlinPlugin/graphdb/execute_script'
  config.log_file       = 'neography.log'
  config.log_enabled    = false
  config.max_threads    = 20
  config.authentication = nil  # 'basic' or 'digest'
  config.username       = nil
  config.password       = nil
  config.parser         = MultiJsonParser
end

class SqlToNeo

  def initialize

    # Launching rest client
    @neo = Neography::Rest.new

    # Creating nodes
    authors
  end

  def authors
    puts 'Computing authors...'

    for a in Author.all
      @neo.create_node('type' => 'author', 'first_name' => a.first_name, 'last_name' => a.last_name)
    end
  end
end

# Launching process
puts 'Migrating SQL Database to Neo4j...'
SqlToNeo.new