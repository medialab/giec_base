# -------------------------------------------------------------------
# Giec Querying
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

# Main Controller
require_relative "tools/CsvExporter.rb"
require_relative "queries/#{ARGV[0]}.rb"

FileUtils.mkdir_p 'results'

q = Query.new
results = q.exec

results.each do |name, csv|
    Exporter.save csv, "results/#{ARGV[0]}_#{name}.csv"
end