class Admin::HomesController < ApplicationController
  def top
    redirect_to admin_root_path
  end
end
