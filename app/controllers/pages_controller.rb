class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @disable_navbar = true
  end

  def admin
    @disable_navbar = true
  end
end
