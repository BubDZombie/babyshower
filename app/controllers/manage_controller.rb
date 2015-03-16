class ManageController < ApplicationController
  before_action :check_logged_in, :except => ['log_in', 'log_in_submit']

  def index
  end

  def log_in
  end

  def log_out
    reset_session
    redirect_to( controller: 'welcome' )
  end

  def log_in_submit
    if( params[:password] && params[:password] == 'New England clam chowder' )
      session[:admin] = true
      redirect_to( action: index )
    else
      redirect_to( action: log_in )
    end
  end

  private

  def check_logged_in
    if( session[:admin] != true )
      redirect_to( action: 'log_in' )
    end
  end
end
