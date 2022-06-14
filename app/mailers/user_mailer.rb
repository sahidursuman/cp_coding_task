class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.bulk_email.subject
  #
  def bulk_email(user, retention_email)
    @user = user
    @retention_email = retention_email

    mail to: @user.email
  end
end
