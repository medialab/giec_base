# -------------------------------------------------------------------
# Giec Participations Importer
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
        puts 'Importing Participations...'
        @AR = nil
        @max_ar = 5
        @header = []
        @participations = []
        @authors = {}

        # Getting authors
        for a in Author.all
            @authors.store(a.id, a)
        end

        # Process
        compute
        save
        puts 'Done !'
    end

    # Loading Csv File
    def load_csv(csv, ar)
        @AR = ar
        CSV.foreach(csv) do |row|

            # Reading Header
            if $. == 1 
                @header = row
            else

                # Yielding row
                agregate = {:id => Taxonomies::Duplicates[row[0]] || row[0], :links => []}
                row[1..-1].each_with_index do |val, index|
                    if val != nil then agregate[:links].push({:chapter => @header[index+1].strip, :role => val.strip}) end
                end
                yield agregate
            end
        end
    end

    # Loading complement
    def load_csv_complement()
        for i in 1..3
            CSV.foreach("feed/AR5_complement#{i}.csv", {:headers => :first_row}) do |row|
                participation = {:ar => 5, :author_id => Taxonomies::Duplicates[row[0]] || row[0], :chapter => row[1], :role => row[2], :wg => row[3].length}
                yield participation
            end
        end
    end

    # Computing model
    def compute

        # Standard files
        for i in 1..@max_ar
            puts "Importing AR #{i}..."
            load_csv("feed/AR#{i}.csv", i) do |p|

                # Looping through participations
                for c in p[:links]
                    pos = c[:chapter].split('.')
                    model = Participation.new(:ar => @AR, :wg => pos[0], :chapter => pos[1], :role => c[:role], :author => @authors[p[:id].to_i])
                    @participations.push(model)
                end
            end
        end
        
        # Special files
        puts "Importing AR 5 complements..."
        load_csv_complement do |p|
            @participations.push(Participation.new(p))
        end

    end

    # Saving to DB
    def save
        Participation.transaction do
            @participations.each do |p, x|
                p.save
            end
        end
    end
end

Importer.new