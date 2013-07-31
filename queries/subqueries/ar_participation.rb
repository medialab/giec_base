# -------------------------------------------------------------------
# Number of Participation subqueries
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Getting total partipations
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