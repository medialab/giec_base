# -------------------------------------------------------------------
# Exporter
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0
require 'json'

class Exporter

    # Main Static Method
    def self.save(type, data, filepath)
        
        if type == :csv
            CSV.open(filepath+'.csv', 'w') do |csv|
                for row in data
                    csv << row
                end
            end
        else
            File.open(filepath+'.json', 'w') do |file|
                file.write data.to_json
            end
        end
    end
end