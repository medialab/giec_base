# -------------------------------------------------------------------
# Giec Mixins
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Generic class helpers
module Helpers

    # Data overload for models
    module Data
        attr_accessor :_data

        def _data
            @_data ||= {}
        end
    end

    # Query export for queries
    module Export
        attr_accessor :export

        def addToExport(data)
            @export ||= []
            @export.push(data)
        end
    end
end
