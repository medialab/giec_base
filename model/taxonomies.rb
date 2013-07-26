# -------------------------------------------------------------------
# Giec Taxonomies
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

module Taxonomies

	# Authors Groups
	Groups = [
		{:symbol => 'AG', :name => 'African Group', :type => 'GEO'},
		{:symbol => 'APG', :name => 'Asian-Pacific Group', :type => 'GEO'},
		{:symbol => 'GRULAC', :name => 'Latin American and Caribbean Group', :type => 'GEO'},
		{:symbol => 'EEG', :name => 'Eastern European Group', :type => 'GEO'},
		{:symbol => 'WEOG', :name => 'Western Europe and Other States Group', :type => 'GEO'},
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
		{:symbol => 'IPCC', :name => 'Intergovernmental Panel on Climate Change'},
		{:symbol => 'NGO', :name => 'Non-Governmental Organization'},
		{:symbol => 'OTHER', :name => 'Other'},
		{:symbol => 'PRO', :name => 'Public Research Organisation'}
	]

	# Roles
	Roles = [
		{:symbol => 'LA', :name => 'Lead Author'},
		{:symbol => 'LCA', :name => 'Lead Coordinating Author'},
		{:symbol => 'RE', :name => 'Review Editor'},
		{:symbol => 'CA', :name => 'Contributing Author'}
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
		{:symbol => 'INT', :name => 'Introduction'},
	]
end