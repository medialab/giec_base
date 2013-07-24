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


# How many AR2 authors come from country which are not OECD
#----------------------------------------------------------
relevant_authors = []
authors = Author.all('participations.ar' => 2)
for author in authors
	for group in author.groupings
		if group.symbol == 'OCDE'
			relevant_authors.push(author)
			break
		end
		next
	end
end
puts 'Total number of authors in AR2 : '+authors.length.to_s
puts 'OECD number : '+relevant_authors.length.to_s
puts 'Other number : '+(authors.length - relevant_authors.length).to_s

# Authors in several WG in AR2
#-----------------------------
# authors = []
# for author in Author.all('participations.ar' => 2)
# 	ps = Participation.all('author.id' => author.id)
# 	wgs = []
# 	for p in ps
# 		if !wgs.include?(p.wg)
# 			wgs.push(p.wg)
# 		end
# 	end
# 	if wgs.length > 1
# 		authors.push(author)
# 	end
# end
# puts 'Number of AR2 authors participating in more than one WG : '+authors.length.to_s
# for a in authors
# 	puts a.first_name+' '+a.last_name
# end

# National Participations
#------------------------
# def national_participations(country)
# 	chapters = {}
# 	participations = Participation.all('author.institutions.country' => country)
# 	for p in participations
# 		if !chapters.has_key?(p.wg.to_s+' '+p.chapter.to_s)
# 			chapters.store(p.wg.to_s+' '+p.chapter.to_s, 1)
# 		else
# 			chapters[p.wg.to_s+' '+p.chapter.to_s] += 1
# 		end
# 	end

# 	chapters = chapters.sort_by {|_key, value| value}
# 	return chapters.reverse
# end

# # french_p = national_participations('France')
# # for p in french_p
# # 	puts p
# # end

# english_p = national_participations('United Kingdom')
# for p in english_p
# 	puts p
# end

# Top Institutions
#-----------------
# institutions = {}
# for author in Author.all('participations.ar' => 2)
# 	for ins in author.institutions
# 		if !institutions.has_key?(ins.name)
# 			institutions.store(ins.name, 1)
# 		else
# 			institutions[ins.name] += 1
# 		end
# 	end
# end

# institutions = institutions.sort_by {|_key, value| value}
# puts institutions.reverse[0..9]