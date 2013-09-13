# -------------------------------------------------------------------
# Giec Database Models
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Dependencies
require 'rubygems'
require 'data_mapper'

module Helpers
    module Data
        attr_accessor :_data

        def _data
            @_data ||= {}
        end
    end
end

# Author
#========
class Author
    include DataMapper::Resource
    include Helpers::Data

    # Properties
    property :id, Serial
    property :first_name, String, :length => 255
    property :last_name, String, :length => 255

    # Links
    has n, :institutions, :through => Resource
    has n, :participations
    has n, :chairman_offices
    has n, :departments, :through => Resource
end

# Institution
#=============
class Institution
    include DataMapper::Resource
    include Helpers::Data

    # Properties
    property :id, Serial
    property :name, String, :length => 255

    # Links
    has n, :departments
    has n, :participations
    has n, :chairman_offices
    belongs_to :country
    belongs_to :type, 'InstitutionType', :parent_key => [:id]
    has n, :authors, :through => Resource
end

# Department
#============
class Department
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :name, String, :length => 255

    # Links
    belongs_to :institution
    has n, :participations
    has n, :chairman_offices
    has n, :authors, :through => Resource
end

# Country
#==========
class Country
    include DataMapper::Resource
    include Helpers::Data

    # Properties
    property :id, Serial
    property :name, String, :length => 255

    # Links
    has n, :institutions
    has n, :groupings
end

# Grouping
#=============
class Grouping
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :symbol, String, :length => 255

    # Links
    belongs_to :country
end

# Groups
#=============
class Group
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :symbol, String, :length => 255
    property :name, String, :length => 255
    property :type, String, :length => 3
end


# Institution Types
#===================
class InstitutionType
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :name, String, :length => 255
    property :symbol, String, :length => 5

    # Links
    has n, :institutions, 'Institution', :child_key => [:id]
end

# Participations
#================
class Participation
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :ar, Integer, :index => true
    property :wg, Integer, :index => true
    property :chapter, String, :length => 4, :index => true
    property :role, String, :length => 4, :index => true

    # Links
    belongs_to :author
    belongs_to :institution, :required => false
    belongs_to :department, :required => false
end

# Chairmen
#==========
class ChairmanOffice
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :ar, Integer, :index => true
    property :wg, Integer, :index => true
    property :role, String, :length => 255
    property :rank, Integer, :index => true

    # Links
    belongs_to :author
    belongs_to :institution, :required => false
    belongs_to :department, :required => false
end

# Assessment Report
#===================
class AssessmentReport
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :year, String, :length => 4

    # Links
    has n, :working_groups
    has n, :chapters
end

# Working Group
#===============
class WorkingGroup
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :number, Integer
    property :title, String, :length => 255

    # Links
    belongs_to :assessment_report
    has n, :chapters
end

# Chapter
#=========
class Chapter
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :number, String, :length => 4
    property :title, String, :length => 255

    # Links
    belongs_to :assessment_report
    belongs_to :working_group
    has n, :types, 'ChapterType', :through => :chapter_chapter_types, :via => :chapter_type
end

# Chapter Links
#===============
class ChapterChapterType
    include DataMapper::Resource

    # Links
    belongs_to :chapter,   :key => true
    belongs_to :chapter_type, :key => true
end

# Chapter Types
#===============
class ChapterType
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :symbol, String, :length => 3
    property :name, String, :length => 255

    # Links
    has n, :chapters, :through => :chapter_chapter_types
end


# Roles
#===============
class Role
    include DataMapper::Resource

    # Properties
    property :id, Serial
    property :symbol, String, :length => 4
    property :name, String, :length => 255
end


# Finalizing
DataMapper.finalize