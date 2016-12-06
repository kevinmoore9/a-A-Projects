class ContactsController < ApplicationController

  def index
    render json: Contact.all
  end

  def update
    ############
    #############
    ############
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.errors.full_messages,
        status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: @contact
  end

  def show
    render json: Contact.find(params[:id])
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end

end
