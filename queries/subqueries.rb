# -------------------------------------------------------------------
# GIEC Subqueries
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Getting total participations
class TotalParticipation

    def self.get
        total_participations = {}
        for ar in 1..5
            participations = repository(:default).adapter.select('SELECT DISTINCT author_id from participations WHERE ar = ?', ar)
            count = participations.length == 0 ? 1 : participations.length
            total_participations.store(ar, count)
        end
        return total_participations
    end
end

# TODO : are they in if several ARs not in WG1
# TODO : drop Contributing Authors
# The Inner Circle
class InnerCircle

    def self.get

        # Getting all WG1 authors
        wg1_authors = Author.all('participations.wg' => 1)

        # Filtering only highly participating ones
        wg1_authors.select! do |author|
            ars = []
            author._data.store(:participations, {})

            for i in 1..5
                p = Participation.first(:author_id => author.id, :wg => 1, :ar => i)
                if p != nil
                    ars.push(p.ar)
                    author._data[:participations].store(i, p)
                end
            end

            author._data.store(:ars, ars)
            ars.length > 1
        end

        # Sorting by participations
        return wg1_authors.sort_by {|x| -x._data[:ars].length}
    end
end