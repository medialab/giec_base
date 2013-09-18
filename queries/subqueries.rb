# -------------------------------------------------------------------
# GIEC Subqueries
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# The Inner Circle
class InnerCircle

    def self.definition1(wg)
        authors = Author.all('participations.wg' => wg)

         return authors.select do |author|
            author._data.store(:ars, [])
            author._data.store(:participations, {})

            for i in 1..5
                p = Participation.first(:author_id => author.id, :wg => wg, :ar => i)
                if p != nil
                    author._data[:ars].push(p.ar)
                    author._data[:participations].store(i, p)
                end
            end

            author._data[:ars].length > 1
        end
    end

    def self.definition2(wg)
        authors = Author.all('participations.wg' => wg)

         return authors.select do |author|
            author._data.store(:ars, [])
            author._data.store(:participations, {})

            for i in 1..5
                p = Participation.first(:author_id => author.id, :wg => wg, :ar => i)
                if p != nil
                    author._data[:ars].push(p.ar)
                    author._data[:participations].store(i, p)
                end
            end

            author._data[:ars].length > 2
        end
    end

    def self.definition3(wg)
        authors = Author.all('participations.wg' => wg)

         return authors.select do |author|
            author._data.store(:ars, [])
            author._data.store(:participations, {})

            for i in 1..5
                p = Participation.first(:author_id => author.id, :wg => wg, :ar => i, :role => ['LA', 'CLA'])
                if p != nil
                    author._data[:ars].push(p.ar)
                    author._data[:participations].store(i, p)
                end
            end

            author._data[:ars].length > 1
        end
    end

    def self.definition4(wg)
        authors = Author.all('participations.wg' => wg)

         return authors.select do |author|
            author._data.store(:ars, [])
            author._data.store(:participations, {})

            for i in 1..5
                # LIMIT
                tp = Participation.all(:author_id => author.id, :wg => wg, :ar => i, :role => ['LA', 'CLA'], :limit => 2)

                if tp.length == 2
                    author._data[:ars].push(tp[0].ar)
                    author._data[:participations].store(i, tp[0])
                end
            end

            author._data[:ars].length > 1
        end
    end
end

# Authors working in more than one working group
class CrossWGAuthors

    def self.get

        return Author.all.select do |author|
            author._data.store(:wgs, [])
            author._data.store(:participations, [])

            (1..3).each do |wg|
                p = Participation.first(:wg => wg, :author_id => author.id)
                if p != nil
                    author._data[:wgs].push p.wg
                    author._data[:participations].push p
                end
            end
            author._data[:wgs].length > 1
        end
    end
end

# Total authors of a Working group
class WGAuthorsIds

    def self.get(wg)
        return authors = repository(:default).adapter.select("SELECT DISTINCT author_id from participations WHERE wg = ?", wg)
    end

    def self.getByAr(ar, wg)
        return authors = repository(:default).adapter.select("SELECT DISTINCT author_id from participations WHERE ar = #{ar} AND wg = #{wg}")
    end
end