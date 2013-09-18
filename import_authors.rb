# -------------------------------------------------------------------
# Giec Authors Importer
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

    # Launching
    def initialize

        # Properties
        puts 'Importing Authors and Institutions...'
        @placeholder_institutions = {}
        @institutions = {}
        @authors = {}
        @countries = {}
        @registers = {}
        @departments = {}
        @taxonomy = {}

        # Temporary exclusion
        @exclusion = [8,40,47,51,62,68,72,73,85,91,109,126,129,134,141,158,165,167,174,176,184,185,227,234,240,244,263,273,281,305,306,317,340,344,352,376,383,388,398,402,422,423,424,429,432,448,459,487,490,516,521,536,537,558,562,566,581,594,609,611,616,622,631,634,639,641,651,668,673,682,685,701,707,709,729,741,759,761,765,766,770,777,807,813,824,848,866,881,894,903,907,908,918,921,924,929,939,945,947,954,958,962,967,969,983,985,1001,1015,1016,1020,1049,1061,1072,1096,1104,1138,1140,1148,1154,1171,1181,1183,1184,1186,1200,1217,1225,1239,1249,1250,1252,1255,1263,1280,1281,1284,1290,1294,1328,1337,1338,1363,1370,1376,1393,1404,1414,1420,1450,1455,1459,1460,1463,1472,1473,1474,1494,1495,1507,1516,1543,1564,1573,1648,1656,1674,1697,1714,1716,1725,1729,1752,1753,1758,1782,1817,1822,1839,1841,1845,1851,1868,1889,1896,1900,1905,1913,1926,1938,1954,1963,1967,1970,1976,1980,1996,2002,2003,2004,2024,2032,2036,2054,2059,2073,2077,2084,2089,2096,2100,2116,2127,2128,2131,2135,2155,2159,2175,2185,2194,2199,2203,2204,2206,2210,2211,2232,2242,2268,2285,2301,2318,2331,2338,2342,2369,2392,2402,2416,2437,2438,2448,2479,2482,2507,2524,2526,2538,2544,2559,2581,2584,2616,2618,2636,2645,2651,2671,2720,2733,2737,2741,2773,2774,2812,2837,2838,2848,2849,2858,2877,2884,2906,2915,2923,2927,2935,2951,2952,2957,2960,2971,2975,2978,3008,3012,3014,3027,3029,3050,3058,3071,3079,3090,3093,3094,3097,3098,3103,3104,3111,3121,3134,3171,3188,3200,3201,3212,3241,3242,3243,3245,3248,3259,3273,3275,3282,3305,3310,3322,3323,3337,3343,3381]
        second_exclusion = [197, 438, 621, 652, 1009, 1383, 1476, 2022, 2098, 2600, 2756]
        @exclusion = @exclusion + second_exclusion

        for i in Institution.all(:name => 'N/A')
            @placeholder_institutions.store(i.country.name, i)
        end

        for t in InstitutionType.all
            @taxonomy.store(t.symbol, t)
        end

        for c in Country.all
            @countries.store(c.name, c.id)
        end

        # Working
        compute
        save

        puts 'Done !'
    end

    # Loading CSV File
    def load_csv
        CSV.foreach("feed/Authors.csv", {:headers => :first_row}) do |row|

            # Users
            aut = {:id => row[0], :first_name => row[1], :last_name => row[2]}
            ins = {:name => row[8], :type => row[7], :department => row[9], :country => row[10]}

            # Yielding rows
            if row[7] != 'IPCC' && !@exclusion.include?(aut[:id].to_i) then yield ins, aut end
        end
    end

    # Getting institutions
    def compute
        
        # Looping
        load_csv do |ins, aut|

            # Registering institution
            if ins[:type] == "INT" and ins[:country] != nil then ins_key = ins[:name]+'||'+ins[:country] else ins_key = ins[:name] end

            if ins[:name] != nil
                if ins[:name] != "N/A" and ins[:name] != ''
                    if !@institutions.has_key?(ins_key)
                        model = Institution.new(:name => ins[:name], :country_id => @countries[ins[:country]])
                        @institutions.store(ins_key, model)
                    else

                        # Registering country if we find it elsewhere
                        if @institutions[ins_key].country == nil and ins[:country] != nil
                            @institutions[ins_key][:country_id] = @countries[ins[:country]]
                        end
                    end

                    # Registering Department
                    depkey = nil
                    if ins[:department] != nil
                        depkey = ins[:department]+'||'+ins[:name]
                        if !@departments.has_key?(depkey)
                            model = Department.new(:name => ins[:department])
                            
                            # Linking to institution
                            @institutions[ins_key].departments << model
                            @departments.store(depkey, model)
                        end
                    end

                    # Registering Institution Types
                    if ins[:type] != nil and ins[:type] != ''
                        if @institutions[ins_key].type == nil
                            @institutions[ins_key].type = @taxonomy[ins[:type]]
                        end
                    end
                end
            end

            # Registering Author
            if !@authors.has_key?(aut[:id])
                model = Author.new(:id => aut[:id], :first_name => aut[:first_name], :last_name => aut[:last_name])
                @authors.store(aut[:id], model)
                @registers.store(aut[:id], [])
            end

            # Author's Institutions
            if ins[:name] != '' and ins[:name] != 'N/A' and ins[:name] != nil
                if !@registers[aut[:id]].include?(ins[:name])
                    @registers[aut[:id]].push(ins[:name])
                    @authors[aut[:id]].institutions << @institutions[ins_key]

                    if depkey != nil
                        @authors[aut[:id]].departments << @departments[depkey]
                    end
                end
            else
                if ins[:country] != nil
                    @authors[aut[:id]].institutions << @placeholder_institutions[ins[:country]]
                end
            end

        end
    end

    # Saving all this mess
    def save
        Institution.transaction do
            @institutions.each do |x, ins|
                ins.save
            end
        end
        puts 'Institutions Done !'
        Department.transaction do
            @departments.each do |x, dep|
                dep.save
            end
        end
        puts 'Departments Done !'
        Author.transaction do
            @authors.each do |x, aut|
                aut.save
            end
        end
        puts 'Auhors Done !'
    end
end

Importer.new