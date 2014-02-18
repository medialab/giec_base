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
    puts 'Migrating SQL Database to Neo4j...'

    # Node scripting index
    @authors = {}
    @chapters = {}

    # Launching rest client
    @neo = Neography::Rest.new

    # Wiping the base
    puts 'Cleaning the database...'
    @neo.execute_script("g.clear()")

    # Computing graph
    authors
    chapters
    edges
  end

  def authors
    puts 'Computing authors...'

    for a in Author.all
      @authors.store(
        a.id,
        @neo.create_node(
        'type' => 'author',
        'first_name' => a.first_name,
        'last_name' => a.last_name
        )
      )
    end
  end

  def chapters
    puts 'Computing chapters...'

    for c in Chapter.all
      @chapters.store(
        "#{c.ar}/#{c.wg}/#{c.number}",
        @neo.create_node('type' => 'chapter', 'title' => c.title)
      )
    end
  end

  def edges
    puts 'Computing edges:'

    # Author -> chapter
    puts '    authors --> chapters'
    for p in Participation.all
      rel = @neo.create_relationship(
        :contribution,
        @authors[p.author_id],
        @chapters["#{p.ar}/#{p.wg}/#{p.chapter}"]
      )

      @neo.set_relationship_properties(rel, {'role' => p.role})
    end

  end
end

# Launching process
SqlToNeo.new
