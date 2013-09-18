# -------------------------------------------------------------------
# Giec Chapters Importer
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

WORKING_GROUPS = {
    '1-1' => 'Scientific Assessment of Climate Change',
    '1-2' => 'Impacts Assessments of Climate Change',
    '1-3' => 'The IPCC Responses Strategies',
    '2-1' => 'The Science of Climate Change',
    '2-2' => 'Impacts, adaptations, and mitigation of Climate Change',
    '2-3' => 'Economic and Social Dimensions of Climate Change',
    '3-1' => 'The Scientific Basis',
    '3-2' => 'Impacts, Adaptation and Vulnerability',
    '3-3' => 'Mitigation',
    '4-1' => 'The Physical Science Basis',
    '4-2' => 'Impacts, Adaptation and Vulnerability',
    '4-3' => 'Mitigation of Climate Change',
    '5-1' => 'The Physical Science Basis',
    '5-2' => 'Impacts, Adaptation and Vulnerability',
    '5-3' => 'Mitigation of Climate Change'
}

class Importer

    # Launcing
    def initialize

        # Properties
        puts 'Importing Chapters...'
        @chapters = []
        @types = {}

        # Getting Chapter Types
        for ctype in ChapterType.all
            @types.store(ctype.symbol, ctype)
        end

        # Process
        compute
        save
        puts 'Done !'
    end

    # Loading Csv File
    def load_csv
        CSV.foreach("feed/Chapters.csv", {:headers => :first_row}) do |row|

            # Yielding row
            ar = AssessmentReport.get(row[0].to_i)
            wg = WorkingGroup.first_or_create(:assessment_report => ar, :number => row[1], :title => WORKING_GROUPS[[row[0], row[1]].join('-')])
            chapter = {:ar => row[0].to_i, :wg => row[1].to_i, :assessment_report => ar, :working_group => wg, :number => row[2], :title => row[3]}
            types = row[4]
            yield chapter, types
        end
    end

    # Computing model
    def compute
        load_csv do |chapter, types|

            # Looping through chapters
            model = Chapter.new(chapter)
            if types != nil
                for type in types.split('/')
                    model.types << @types[type]
                end
            end

            @chapters.push(model)
        end
    end

    # Saving to DB
    def save
        Chapter.transaction do
            @chapters.each do |c, x|
                c.save
            end
        end
    end
end

Importer.new