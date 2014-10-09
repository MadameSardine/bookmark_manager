get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.new(:email => params[:email],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

post '/users/token' do
	user = User.first(:email => params[:email])
	user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	user.password_token_timestamp = Time.now
	user.save
	@user = user
	flash[:notice] = "A link to reset your password has been sent to your mailbox"
	erb :"sessions/new"
end

get '/users/reset_password/:token' do
	@user = User.first(:password_token => params[:token])
		erb :"users/reset_password"
end

post '/users/reset_password/update' do
	@user = User.first(:password_token => params[:token])
	@user.update(:password => params[:password],
				:password_confirmation => params[:password_confirmation], :password_token => '')
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end