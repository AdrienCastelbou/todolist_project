class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def create
    @email = Email.create(object: Faker::Book.title, body: Faker::Book.genre)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
      
    end
  end

  def show
    
    @email = Email.find(params[:id])
    @email.update(read: true)
    puts @email.read
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
      
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end
  def update 
    @email = Email.find(params[:id])
    if @email.read == false
      @email.update(read: true)
    elsif @email.read == true 
      @email.update(read: false)
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end
end
