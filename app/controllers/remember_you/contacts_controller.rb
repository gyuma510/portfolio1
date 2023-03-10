class RememberYou::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_check, only: [:create]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, current_user).deliver
      redirect_to remember_you_records_path, notice: 'お問い合わせ内容を送信しました'
    else
      flash.now[:failer] = "送信できませんでした"
      render :new
    end
  end

  def guest_check
    if current_user == User.find_by(email: "guests@example.com")
      flash[:notice] = "お問い合わせを送信するには、会員登録が必要です。"
      redirect_to remember_you_records_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :content)
  end
end
