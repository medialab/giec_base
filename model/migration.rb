# -------------------------------------------------------------------
# Giec Database Migration
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Dependencies
require 'rubygems'
require 'data_mapper'
require_relative 'connection.rb'
require_relative 'model.rb'
require_relative 'taxonomies.rb'

# Database Migration
#=====================
puts 'Migrating Database...'
DataMapper.auto_migrate!

# Taxonomies
for group in Taxonomies::Groups
	Group.create(group)
end

for type in Taxonomies::InstitutionTypes
	InstitutionType.create(type)
end

for role in Taxonomies::Roles
	Role.create(role)
end

for ar in Taxonomies::AssessmentReports
	AssessmentReport.create(ar)
end

puts 'Done !'