# -------------------------------------------------------------------
# Giec Taxonomies
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

module Taxonomies

    # Exclusion
    Exclusion = [8,40,47,51,62,68,72,73,85,91,109,126,129,134,141,158,165,167,174,176,184,185,227,234,240,244,263,273,281,305,306,317,340,344,352,376,383,388,398,402,422,423,429,432,448,459,487,490,516,521,536,537,558,562,566,581,594,609,611,616,622,631,634,639,641,651,668,673,682,685,701,707,709,729,741,759,761,765,766,770,777,807,813,824,848,866,881,894,903,907,908,918,921,924,929,939,945,947,954,958,962,967,969,983,985,1001,1015,1016,1020,1049,1061,1072,1096,1104,1138,1140,1148,1154,1171,1181,1183,1184,1186,1200,1217,1225,1239,1249,1250,1252,1255,1263,1280,1281,1284,1290,1294,1328,1337,1338,1363,1370,1376,1393,1404,1414,1420,1450,1455,1459,1460,1463,1472,1473,1474,1494,1495,1507,1516,1543,1564,1573,1648,1656,1674,1697,1714,1716,1725,1729,1752,1753,1758,1782,1817,1822,1839,1841,1845,1851,1868,1889,1896,1900,1905,1913,1926,1938,1954,1963,1967,1970,1976,1980,1996,2002,2003,2004,2024,2032,2036,2054,2059,2073,2077,2084,2089,2096,2100,2116,2127,2128,2131,2135,2155,2159,2175,2185,2194,2199,2203,2204,2206,2210,2211,2232,2242,2268,2285,2301,2318,2331,2338,2342,2369,2392,2402,2416,2437,2438,2448,2479,2482,2507,2524,2526,2538,2544,2559,2581,2584,2616,2618,2636,2645,2651,2671,2720,2733,2737,2741,2773,2774,2812,2837,2838,2848,2849,2858,2877,2884,2906,2915,2923,2927,2935,2951,2952,2957,2960,2971,2975,2978,3008,3012,3014,3027,3029,3050,3058,3071,3079,3090,3093,3094,3097,3098,3104,3111,3121,3134,3171,3188,3200,3201,3212,3241,3242,3243,3245,3248,3259,3273,3275,3282,3305,3310,3322,3323,3337,3343,3381,197,438,621,652,1009,1383,1476,2022,2098,2600,2756]
    Duplicates = {"48"=>"3633", "214"=>"211", "361"=>"366", "368"=>"363", "369"=>"365", "713"=>"711", "839"=>"842", "897"=>"899", "946"=>"948", "1085"=>"1088", "1117"=>"1113", "1162"=>"1160", "1192"=>"1190", "1222"=>"1219", "1396"=>"1394", "1429"=>"1431", "1525"=>"1523", "1601"=>"1599", "1625"=>"1623", "1702"=>"1700", "1728"=>"1726", "1908"=>"1906", "1966"=>"1964", "1979"=>"1975", "2031"=>"2029", "2072"=>"2070", "2139"=>"2138", "2244"=>"2246", "2359"=>"2357", "2519"=>"2517", "2520"=>"2518", "2657"=>"2655", "2666"=>"2668", "2801"=>"2804", "2825"=>"2827", "2961"=>"2965", "3149"=>"3157", "3168"=>"3166", "3172"=>"3174", "3328"=>"3330", "3360"=>"3347", "3368"=>"3366", "3462"=>"1593", "3628"=>"21", "3652"=>"250", "3673"=>"445", "3677"=>"460", "3691"=>"526", "3715"=>"681", "3726"=>"762", "3727"=>"774", "3728"=>"781", "3761"=>"931", "3777"=>"1057", "3778"=>"1058", "3779"=>"1059", "3785"=>"1093", "3788"=>"1112", "3798"=>"1216", "3800"=>"1246", "3807"=>"1292", "3809"=>"1321", "3816"=>"1353", "3826"=>"1406", "3827"=>"1407", "3838"=>"1482", "3846"=>"1537", "3859"=>"1607", "3882"=>"1844", "3884"=>"1863", "3895"=>"1959", "3912"=>"2087", "3934"=>"2271", "3958"=>"2486", "3968"=>"2568", "3978"=>"2639", "3990"=>"2759", "3994"=>"2846", "4004"=>"2911", "4009"=>"2950", "4020"=>"3039", "4023"=>"3056", "4042"=>"3246", "4055"=>"3357", "4060"=>"3379", "4063"=>"4", "4067"=>"27", "4073"=>"59", "4076"=>"66", "4080"=>"71", "4091"=>"119", "4093"=>"120", "4096"=>"127", "4097"=>"130", "4102"=>"171", "4110"=>"213", "4113"=>"221", "4121"=>"231", "4122"=>"233", "4123"=>"241", "4132"=>"300", "4137"=>"310", "4139"=>"314", "4140"=>"315", "4144"=>"323", "4148"=>"337", "4150"=>"360", "4158"=>"395", "4163"=>"407", "4164"=>"408", "4175"=>"463", "4178"=>"468", "4185"=>"495", "4192"=>"512", "4193"=>"520", "4196"=>"538", "4199"=>"553", "4201"=>"556", "4210"=>"593", "4216"=>"604", "4219"=>"610", "4220"=>"615", "4239"=>"659", "4240"=>"660", "4242"=>"669", "4246"=>"700", "4247"=>"702", "4248"=>"705", "4256"=>"716", "4263"=>"756", "4264"=>"757", "4265"=>"763", "4269"=>"782", "4270"=>"784", "4276"=>"805", "4277"=>"810", "4278"=>"815", "4280"=>"820", "4281"=>"823", "4284"=>"828", "4292"=>"846", "4293"=>"847", "4298"=>"863", "4299"=>"864", "4301"=>"870", "4302"=>"872", "4303"=>"892", "4307"=>"900", "4309"=>"912", "4311"=>"925", "4318"=>"938", "4330"=>"982", "4336"=>"995", "4340"=>"998", "4345"=>"1019", "4349"=>"1041", "4353"=>"1062", "4354"=>"1071", "4355"=>"1076", "4357"=>"1077", "4359"=>"1083", "4360"=>"1084", "4361"=>"1090", "4371"=>"1122", "4377"=>"1168", "4382"=>"1194", "4384"=>"1203", "4385"=>"1204", "4389"=>"1206", "4393"=>"1219", "4399"=>"1245", "4401"=>"1253", "4406"=>"1274", "4413"=>"1283", "4419"=>"1295", "4420"=>"1304", "4424"=>"1315", "4429"=>"1331", "4433"=>"1368", "4437"=>"1386", "4439"=>"1390", "4440"=>"1405", "4444"=>"1424", "4445"=>"1430", "4447"=>"1436", "4453"=>"1453", "4454"=>"1457", "4455"=>"1462", "4458"=>"1467", "4462"=>"1500", "4463"=>"1504", "4464"=>"1512", "4466"=>"1514", "4467"=>"1517", "4469"=>"1522", "4470"=>"1524", "4476"=>"1534", "4477"=>"1535", "4483"=>"1565", "4485"=>"1571", "4489"=>"1579", "4493"=>"3856", "4495"=>"1606", "4497"=>"1620", "4501"=>"1640", "4502"=>"1643", "4506"=>"1657", "4507"=>"1664", "4512"=>"1689", "4517"=>"1699", "4524"=>"1726", "4533"=>"1757", "4537"=>"1759", "4538"=>"1761", "4546"=>"1779", "4554"=>"1812", "4558"=>"1816", "4562"=>"1844", "4564"=>"1847", "4566"=>"1849", "4567"=>"1850", "4568"=>"1854", "4575"=>"1871", "4576"=>"1879", "4579"=>"1894", "4587"=>"1911", "4588"=>"1911", "4590"=>"1914", "4593"=>"1924", "4594"=>"1930", "4596"=>"1939", "4597"=>"1941", "4600"=>"1944", "4606"=>"1965", "4608"=>"1989", "4615"=>"2007", "4624"=>"2038", "4628"=>"2055", "4635"=>"2074", "4639"=>"2083", "4648"=>"2107", "4649"=>"2107", "4658"=>"2136", "4659"=>"2142", "4663"=>"2152", "4664"=>"2160", "4669"=>"2192", "4672"=>"2202", "4673"=>"2205", "4674"=>"2214", "4675"=>"2219", "4677"=>"2220", "4683"=>"2228", "4688"=>"2264", "4692"=>"2279", "4693"=>"2280", "4697"=>"2291", "4704"=>"2307", "4710"=>"2319", "4711"=>"2320", "4713"=>"2327", "4714"=>"2332", "4715"=>"2344", "4716"=>"2354", "4719"=>"2366", "4727"=>"2383", "4730"=>"2389", "4732"=>"2401", "4735"=>"2405", "4736"=>"2406", "4741"=>"2421", "4743"=>"2430", "4751"=>"2472", "4754"=>"2480", "4755"=>"2481", "4757"=>"2484", "4768"=>"2504", "4769"=>"2513", "4771"=>"2517", "4772"=>"2521", "4778"=>"2542", "4784"=>"2569", "4785"=>"2573", "4786"=>"2576", "4789"=>"2582", "4797"=>"2611", "4801"=>"2627", "4812"=>"2665", "4816"=>"2681", "4817"=>"2683", "4822"=>"2690", "4823"=>"2693", "4831"=>"2715", "4832"=>"2717", "4839"=>"2734", "4842"=>"2749", "4844"=>"2753", "4848"=>"2771", "4859"=>"2823", "4860"=>"2824", "4862"=>"2840", "4869"=>"2869", "4871"=>"2874", "4880"=>"2908", "4883"=>"2926", "4896"=>"2992", "4902"=>"3019", "4911"=>"3060", "4919"=>"3087", "4921"=>"3089", "4926"=>"3107", "4932"=>"3126", "4935"=>"3132", "4936"=>"3133", "4938"=>"3150", "4945"=>"3161", "4948"=>"3165", "4950"=>"3167", "4952"=>"3176", "4955"=>"3186", "4959"=>"3195", "4965"=>"3228", "4966"=>"3229", "4977"=>"3255", "4979"=>"3258", "4982"=>"3270", "4984"=>"3271", "4985"=>"3277", "4986"=>"3279", "4988"=>"3289", "4993"=>"3324", "4997"=>"3334", "5007"=>"3363"}


    # Authors Groups
    Groups = [
        {:symbol => 'AG', :name => 'African Group', :type => 'GEO'},
        {:symbol => 'APG', :name => 'Asian-Pacific Group', :type => 'GEO'},
        {:symbol => 'GRULAC', :name => 'Latin American and Caribbean Group', :type => 'GEO'},
        {:symbol => 'EEG', :name => 'Eastern European Group', :type => 'GEO'},
        {:symbol => 'WEOG', :name => 'Western Europe and Other States Group', :type => 'GEO'},
        {:symbol => 'NA', :name => 'Non Available', :type => 'GEO'},
        {:symbol => 'WMONA', :name => 'Non Available', :type => 'WMO'},
        {:symbol => 'AFR', :name => 'Africa', :type => 'WMO'},
        {:symbol => 'SWP', :name => 'South-West Pacific', :type => 'WMO'},
        {:symbol => 'ASI', :name => 'Asia', :type => 'WMO'},
        {:symbol => 'EUR', :name => 'Europe', :type => 'WMO'},
        {:symbol => 'NAC', :name => 'North America, Central America and the Caribbean', :type => 'WMO'},
        {:symbol => 'SAM', :name => 'South America', :type => 'WMO'},
        {:symbol => 'DdC', :name => 'Developed Countries', :type => 'ECO'},
        {:symbol => 'EiT', :name => 'Economies in Transition', :type => 'ECO'},
        {:symbol => 'DgE', :name => 'Developing Economies', :type => 'ECO'},
        {:symbol => 'OCDE', :name => 'OECD', :type => 'ECO'},
        {:symbol => 'BRICS', :name => 'BRICS', :type => 'ECO'},
        {:symbol => 'G8', :name => 'G8', :type => 'ECO'},
        {:symbol => 'G20', :name => 'G20', :type => 'ECO'},
        {:symbol => 'G77', :name => 'G77', :type => 'ECO'},
        {:symbol => 'AOGCM', :name => 'Countries with Coupled Atmosphere-Ocean Global Climate Models', :type => 'CLI'},
        {:symbol => 'A1', :name => 'Annex I', :type => 'CLI'},
        {:symbol => 'NA1', :name => 'Non-Annex I', :type => 'CLI'},
        {:symbol => 'LCDs', :name => 'Least Developed Countries', :type => 'CLI'},
        {:symbol => 'AOSIS', :name => 'Alliance of Small Island States', :type => 'CLI'},
        {:symbol => 'EU', :name => 'European Union', :type => 'CLI'},
        {:symbol => 'UG', :name => 'Umbrella Group', :type => 'CLI'},
        {:symbol => 'CfRN', :name => 'Coalition of Rainforest Nations', :type => 'CLI'},
        {:symbol => 'CACAM', :name => 'Central Asia, Caucasus and Moldova', :type => 'CLI'},
        {:symbol => 'OPEC', :name => 'Organization of the Petroleum Exporting Countries', :type => 'CLI'},
        {:symbol => 'LAS', :name => 'League of Arab States', :type => 'CLI'},
        {:symbol => 'EiG', :name => 'Environmental Integrity Group', :type => 'CLI'},
        {:symbol => 'AILAC', :name => 'Alliance of Latin America and the Caribbean', :type => 'CLI'},
        {:symbol => 'ALBA', :name => 'Bolivarian Alliance for the Peoples of our America', :type => 'CLI'},
        {:symbol => 'OIF', :name => 'Organisation Internationale de la Francophonie', :type => 'CLI'}
    ]

    # Institution Types
    InstitutionTypes = [
        {:symbol => 'AS', :name => 'Academy of Science'},
        {:symbol => 'COMP', :name => 'Company'},
        {:symbol => 'CONS', :name => 'Consultants'},
        {:symbol => 'FND', :name => 'Foundation'},
        {:symbol => 'GA', :name => 'Government Agency'},
        {:symbol => 'HEI', :name => 'Higher Education Institution'},
        {:symbol => 'INDV', :name => 'Individual'},
        {:symbol => 'INT', :name => 'International Institution'},
        {:symbol => 'NGO', :name => 'Non-Governmental Organization'},
        {:symbol => 'OTHER', :name => 'Other'},
        {:symbol => 'PRO', :name => 'Public Research Organisation'},
        {:symbol => 'N/A', :name => 'Non Available'}
    ]

    # Roles
    Roles = [
        {:symbol => 'LCA', :name => 'Coordinating Lead Author', :rank => 1},
        {:symbol => 'LA', :name => 'Lead Author', :rank => 2},
        {:symbol => 'RE', :name => 'Review Editor', :rank => 3},
        {:symbol => 'CA', :name => 'Contributing Author', :rank => 4}
    ]

    # Assessment Reports
    AssessmentReports = [
        {:year => '1990'},
        {:year => '1995'},
        {:year => '2001'},
        {:year => '2007'},
        {:year => '2013'}
    ]

    # Chapter Types
    ChapterTypes = [
        {:symbol => 'GHG', :name => 'Greenhouse Gases'},
        {:symbol => 'AER', :name => 'Aerosols'},
        {:symbol => 'RAD', :name => 'Radiative Forcing'},
        {:symbol => 'CLI', :name => 'Climate Processes'},
        {:symbol => 'MOD', :name => 'Model Evaluation'},
        {:symbol => 'EQU', :name => 'Equilibrium Climate Change'},
        {:symbol => 'PRO', :name => 'Projections of Global Climate Change'},
        {:symbol => 'OBS', :name => 'Observate Climate Variability'},
        {:symbol => 'DET', :name => 'Detection and Attribution'},
        {:symbol => 'SEA', :name => 'Sea Level Change'},
        {:symbol => 'EFF', :name => 'Effects on Ecosystems'},
        {:symbol => 'ADV', :name => 'Advancing Understanding'},
        {:symbol => 'OVE', :name => 'Climate System: Overview'},
        {:symbol => 'RAD', :name => 'Radiative Forcing'},
        {:symbol => 'CAR', :name => 'Carbon Cycle and Biogeochemistry'},
        {:symbol => 'ATM', :name => 'Atmosphere and Surface'},
        {:symbol => 'REG', :name => 'Regional Downscaling'},
        {:symbol => 'SCE', :name => 'Scenario Development'},
        {:symbol => 'HIS', :name => 'History of Climate Change: Overview'},
        {:symbol => 'CRY', :name => 'Cryosphere'},
        {:symbol => 'OCE', :name => 'Oceans'},
        {:symbol => 'PAL', :name => 'Paleoclimate'},
        {:symbol => 'INT', :name => 'Introduction'}
    ]

    # Countries
    Countries = [
        {:name => "N/A", :groupings => "NA/WMONA"},
        {:name => "Albania", :groupings => "EEG/EiT/NA1/OIF/EUR"},
        {:name => "Algeria", :groupings => "AG/DgE/G77/NA1/OPEC/LAS/AFR"},
        {:name => "Antigua", :groupings => "GRULAC/DgE/G77/NA1/AOSIS/ALBA/NAC"},
        {:name => "Argentina", :groupings => "GRULAC/DgE/G20/G77/NA1/CfRN/SAM"},
        {:name => "Australia", :groupings => "WEOG/DdC/OCDE/G20/AOGCM/A1/UG/SWP"},
        {:name => "Austria", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Bangladesh", :groupings => "APG/DgE/G77/NA1/LDCs/CfRN/ASI"},
        {:name => "Barbados", :groupings => "GRULAC/DgE/G77/NA1/AOSIS/NAC"},
        {:name => "Belgium", :groupings => "WEOG/DdC/OCDE/A1/EU/OIF/EUR"},
        {:name => "Belize", :groupings => "GRULAC/G77/NA1/AOSIS/CfRN/NAC"},
        {:name => "Benin", :groupings => "AG/G77/NA1/LDCs/OIF/AFR"},
        {:name => "Bermuda", :groupings => "GRULAC/NAC"},
        {:name => "Bolivia", :groupings => "GRULAC/DgE/G77/NA1/ALBA/SAM"},
        {:name => "Botswana", :groupings => "AG/DgE/G77/NA1/AFR"},
        {:name => "Brazil", :groupings => "GRULAC/DgE/BRICS/G20/G77/NA1/SAM"},
        {:name => "Bulgaria", :groupings => "EEG/DdC/A1/EU/OIF/EUR"},
        {:name => "Cambodia", :groupings => "APG/G77/NA1/LDCs/OIF/ASI"},
        {:name => "Cameroon", :groupings => "AG/AFR"},
        {:name => "Canada", :groupings => "WEOG/DdC/OCDE/G8/G20/AOGCM/A1/UG/OIF/NAC"},
        {:name => "Chad", :groupings => "AG/DgE/G77/NA1/LDCs/OIF/AFR"},
        {:name => "Chile", :groupings => "GRULAC/DgE/OCDE/G77/NA1/CfRN/AILAC/SAM"},
        {:name => "China", :groupings => "APG/DgE/BRICS/G20/G77/AOGCM/NA1/ASI"},
        {:name => "Colombia", :groupings => "GRULAC/DgE/G77/NA1/AILAC/SAM"},
        {:name => "Costa Rica", :groupings => "GRULAC/DgE/G77/NA1/CfRN/AILAC/NAC"},
        {:name => "Cuba", :groupings => "GRULAC/DgE/G77/NA1/AOSIS/ALBA/NAC"},
        {:name => "Czech Republic", :groupings => "EEG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Denmark", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Ecuador", :groupings => "GRULAC/DgE/G77/NA1/CfRN/OPEC/ALBA/SAM"},
        {:name => "Egypt", :groupings => "AG/DgE/G77/NA1/LAS/OIF/AFR"},
        {:name => "El Salvador", :groupings => "GRULAC/DgE/G77/NA1/CfRN/NAC"},
        {:name => "Ethiopia", :groupings => "AG/DgE/G77/NA1/LDCs/AFR"},
        {:name => "Fiji", :groupings => "APG/G77/NA1/AOSIS/CfRN/SWP"},
        {:name => "Finland", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "France", :groupings => "WEOG/DdC/OCDE/G8/G20/AOGCM/A1/EU/OIF/EUR"},
        {:name => "Germany", :groupings => "WEOG/DdC/OCDE/G8/G20/AOGCM/A1/EU/EUR"},
        {:name => "Ghana", :groupings => "AG/DgE/G77/NA1/CfRN/OIF/AFR"},
        {:name => "Greece", :groupings => "WEOG/DdC/OCDE/A1/EU/OIF/EUR"},
        {:name => "Guatemala", :groupings => "GRULAC/DgE/G77/NA1/CfRN/AILAC/NAC"},
        {:name => "Guinea", :groupings => "AG/DgE/G77/NA1/LDCs/OIF/AFR"},
        {:name => "Hong Kong", :groupings => "APG/DgE/ASI"},
        {:name => "Hungary", :groupings => "EEG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Iceland", :groupings => "WEOG/DdC/OCDE/A1/UG/EUR"},
        {:name => "India", :groupings => "APG/DgE/BRICS/G20/G77/NA1/ASI"},
        {:name => "Indonesia", :groupings => "APG/DgE/G20/G77/NA1/CfRN/SWP"},
        {:name => "Iran", :groupings => "APG/DgE/G77/NA1/OPEC/ASI"},
        {:name => "Ireland", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Israel", :groupings => "WEOG/DgE/OCDE/NA1/EUR"},
        {:name => "Italy", :groupings => "WEOG/DdC/OCDE/G8/G20/A1/EU/EUR"},
        {:name => "Jamaica", :groupings => "GRULAC/DgE/G77/NA1/AOSIS/NAC"},
        {:name => "Japan", :groupings => "APG/DdC/OCDE/G8/G20/AOGCM/A1/UG/ASI"},
        {:name => "Kazakhstan", :groupings => "APG/EiT/NA1/CACAM/ASI"},
        {:name => "Kenya", :groupings => "AG/DgE/G77/NA1/CfRN/AFR"},
        {:name => "Kiribati", :groupings => "APG/NA1/LDCs/AOSIS/SWP"},
        {:name => "Kuwait", :groupings => "APG/DgE/G77/NA1/OPEC/LAS/ASI"},
        {:name => "Laos", :groupings => "APG/G77/NA1/LDCs/OIF/ASI"},
        {:name => "Lithuania", :groupings => "EEG/DdC/A1/EU/EUR"},
        {:name => "Madagascar", :groupings => "AG/DgE/G77/NA1/LDCs/CfRN/OIF/AFR"},
        {:name => "Malawi", :groupings => "AG/DgE/G77/NA1/LDCs/AFR"},
        {:name => "Malaysia", :groupings => "APG/DgE/G77/NA1/CfRN/SWP"},
        {:name => "Maldives", :groupings => "APG/G77/NA1/AOSIS/ASI"},
        {:name => "Malta", :groupings => "WEOG/DdC/A1/AOSIS/EU/EUR"},
        {:name => "Mauritius", :groupings => "AG/DgE/G77/NA1/AOSIS/OIF/AFR"},
        {:name => "Mexico", :groupings => "GRULAC/DgE/OCDE/G20/NA1/EIG/NAC"},
        {:name => "Moldova", :groupings => "EEG/EiT/NA1/CACAM/OIF/EUR"},
        {:name => "Monaco", :groupings => "WEOG/A1/EIG/OIF/EUR"},
        {:name => "Montenegro", :groupings => "EEG/EUR"},
        {:name => "Mongolia", :groupings => "APG/G77/NA1/ASI"},
        {:name => "Morocco", :groupings => "AG/DgE/G77/NA1/LAS/OIF/AFR"},
        {:name => "Mozambique", :groupings => "AG/DgE/G77/NA1/LDCs/AFR"},
        {:name => "Namibia", :groupings => "AG/DgE/G77/NA1/AFR"},
        {:name => "Nepal", :groupings => "APG/DgE/G77/NA1/LDCs/ASI"},
        {:name => "New Zealand", :groupings => "WEOG/DdC/OCDE/A1/UG/SWP"},
        {:name => "Nigeria", :groupings => "AG/DgE/G77/NA1/CfRN/OPEC/AFR"},
        {:name => "Norway", :groupings => "WEOG/DdC/OCDE/AOGCM/A1/UG/EUR"},
        {:name => "Oman", :groupings => "APG/DgE/G77/NA1/LAS/ASI"},
        {:name => "Qatar", :groupings => "APG/ASI"},
        {:name => "Pakistan", :groupings => "APG/DgE/G77/NA1/CfRN/ASI"},
        {:name => "Papua New Guinea", :groupings => "APG/DgE/G77/NA1/CfRN/SWP"},
        {:name => "Peru", :groupings => "GRULAC/DgE/G77/NA1/AILAC/SAM"},
        {:name => "Philippines", :groupings => "APG/DgE/G77/NA1/SWP"},
        {:name => "Poland", :groupings => "EEG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Portugal", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Puerto Rico", :groupings => "GRULAC/AOSIS/NAC"},
        {:name => "Romania", :groupings => "EEG/DdC/A1/EU/OIF/EUR"},
        {:name => "Russian Federation", :groupings => "EEG/EiT/BRICS/G8/G20/AOGCM/A1/UG/EUR"},
        {:name => "Samoa", :groupings => "APG/G77/NA1/LDCs/AOSIS/CfRN/SWP"},
        {:name => "Saudi Arabia", :groupings => "APG/DgE/G20/G77/NA1/OPEC/LAS/ASI"},
        {:name => "Senegal", :groupings => "AG/DgE/G77/NA1/LDCs/OIF/AFR"},
        {:name => "Seychelles", :groupings => "AG/G77/NA1/AOSIS/OIF/AFR"},
        {:name => "Sierra Leone", :groupings => "AG/DgE/G77/NA1/LDCs/CfRN/AFR"},
        {:name => "Singapore", :groupings => "APG/DgE/G77/NA1/AOSIS/SWP"},
        {:name => "Slovakia", :groupings => "EEG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Slovenia", :groupings => "EEG/DdC/OCDE/A1/EU/EUR"},
        {:name => "South Africa", :groupings => "AG/DgE/BRICS/G20/G77/NA1/AFR"},
        {:name => "South Korea", :groupings => "APG/DgE/OCDE/G20/AOGCM/NA1/EIG/ASI"},
        {:name => "Spain", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Sri Lanka", :groupings => "APG/DgE/G77/NA1/ASI"},
        {:name => "Sudan", :groupings => "AG/DgE/G77/NA1/LDCs/LAS/AFR"},
        {:name => "Swaziland", :groupings => "AG/AFR"},
        {:name => "Sweden", :groupings => "WEOG/DdC/OCDE/A1/EU/EUR"},
        {:name => "Switzerland", :groupings => "WEOG/DdC/OCDE/A1/EIG/OIF/EUR"},
        {:name => "Taiwan", :groupings => "APG/DgE/ASI"},
        {:name => "Tanzania", :groupings => "AG/DgE/G77/NA1/LDCs/AFR"},
        {:name => "Thailand", :groupings => "APG/DdC/G77/NA1/CfRN/ASI"},
        {:name => "The Gambia", :groupings => "AG/DgE/G77/NA1/LDCs/AFR"},
        {:name => "The Netherlands", :groupings => "WEOG/DdC/OCDE/A1/AOSIS/EU/EUR"},
        {:name => "Togo", :groupings => "AG/DgE/G77/NA1/LDCs/OIF/AFR"},
        {:name => "Trinidad and Tobago", :groupings => "GRULAC/DgE/G77/NA1/AOSIS/NAC"},
        {:name => "Tunisia", :groupings => "AG/DgE/G77/NA1/LAS/OIF/AFR"},
        {:name => "Turkey", :groupings => "WEOG/DgE/OCDE/G20/A1/EUR"},
        {:name => "Turkmenistan", :groupings => "APG/EiT/G77/NA1/CACAM/ASI"},
        {:name => "USA", :groupings => "WEOG/DdC/OCDE/G8/G20/AOGCM/A1/UG/NAC"},
        {:name => "USSR", :groupings => "EEG/EiT/BRICS/G8/G20/AOGCM/A1/UG/EUR"},
        {:name => "Uganda", :groupings => "AG/DgE/G77/NA1/LDCs/CfRN/AFR"},
        {:name => "Ukraine", :groupings => "EEG/EiT/A1/UG/EUR"},
        {:name => "United Kingdom", :groupings => "WEOG/DdC/OCDE/G8/G20/AOGCM/A1/EU/EUR"},
        {:name => "Uruguay", :groupings => "GRULAC/DgE/G77/NA1/CfRN/SAM"},
        {:name => "Uzbekistan", :groupings => "APG/EiT/NA1/CACAM/ASI"},
        {:name => "Venezuela", :groupings => "GRULAC/DgE/G77/NA1/OPEC/AILAC/SAM"},
        {:name => "Vietnam", :groupings => "APG/DgE/G77/NA1/CfRN/OIF/ASI"},
        {:name => "Zambia", :groupings => "AG/DgE/G77/NA1/LDCs/AFR"},
        {:name => "Zimbabwe", :groupings => "AG/DgE/G77/NA1/AFR"}
    ]
end