class GroupMailer < ApplicationMailer
  def notice_email(user, group, title, body)
    @user = user
    @group = group
    @body = body

    mail(
      to: user.email,
      subject: title
    )
  end
end
