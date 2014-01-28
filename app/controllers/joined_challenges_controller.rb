class JoinedChallengesController < ApplicationController
	before_filter :set_user
	def new
		#TODO make sure the challenge is not expired
		@to_join = JoinedChallenge.new
		@to_join.challenge_id = params["challenge_id"]
		@to_join.user_id = params["user_id"]

	end

	# POST /users/:user_id/challenges/:challenge_id
	def create
		#	#raise challenge_params
		#	#@challenge = Challenge.new(challenge_params)
		#	@challenge = @user.challenges.build(challenge_params)
		#TODO make sure the challenge is not expired
		@to_join = JoinedChallenge.new
		@to_join.challenge_id = params["challenge_id"]
		@to_join.user_id = params["user_id"]
		@to_join.kilo_walked = 0
		@to_join.kilo_ran = 0

		#The following lines determine whether there is any actively joined challenge going on
		#If there is none, this newly created challenge will be the one active. Else, it will
		#not be active
		@active_joined_challenge = JoinedChallenge.where("user_id = ? AND active = ?", params["user_id"],true)
		if(@active_joined_challenge.length == 0)
			@to_join.active = true
		else
			@to_join.active = false
		end

		#The following chunk of code basically creates a mark on the user's stats of the day
		#he/she joins the challenge. That way, we can find how many miles walked/ran
		#on the joining date by subtracting the data from the joined date by the 
		#saved data.
		todays_stats = (Stat.where("stat_date = ? AND user_id = ?",Date.today, @user.id))[0]
		@to_join.kilos_had_ran_on_join_date = todays_stats.kilometers_running
		@to_join.kilos_had_walked_on_join_date = todays_stats.kilometers_walking

		respond_to do |format|
			if @to_join.save 
				format.html { redirect_to user_challenges_url(@user), notice: 'User was successfully joined a challenge.' }
			else
				format.html { render action: 'new' }
				format.json { render json: @to_join.errors, status: :unprocessable_entity }
			end
		end

	end

	# UPDATE /users/:user_id/challenges/:challenge_id
	def make_active
		#make all active challenges inactive
		@active_joined_challenge = JoinedChallenge.where("user_id = ? AND active = ?", params["user_id"],true)
		@active_joined_challenge.each do |a|
			a.active = false
			a.save
		end

		@joined_challenge = JoinedChallenge.where("user_id = ? AND challenge_id = ?", params["user_id"],params["challenge_id"])[0]
		@joined_challenge.active = true
		respond_to do |format|
			if @joined_challenge.save
				format.html { redirect_to user_challenges_url(@user) }
			end
		end

	end

	# DELETE /stats/1
	# DELETE /users/:user_id/challenges/:challenge_id
	def destroy
		@to_delete = JoinedChallenge.where("user_id = ? AND challenge_id = ?", params["user_id"],params["challenge_id"])
		@to_delete.destroy_all

		respond_to do |format|
			format.html { redirect_to user_challenges_url(@user)}
			format.json { head :no_content }
		end
	end

	private
	def set_user
		@user = User.find(params["user_id"])
	end



end
