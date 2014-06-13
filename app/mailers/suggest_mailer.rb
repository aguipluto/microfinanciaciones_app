class SuggestMailer < ActionMailer::Base
  default from: "contacte@microfinanciacionesceu.com"

  def answer_email(suggest)
    @suggest = suggest
    email_with_name = 'Microfinanciaciones CEU'
    mail(to: @suggest.email, subject: 'RE: ' + @suggest.title)
  end
end
