class VolunteerMailer < ActionMailer::Base
  default from: "voluntarios@microfinanciacionesceu.com"

  def answer_email(volunteer)
    @volunteer = volunteer
    mail(to: @volunteer.user.email, subject: 'Re: Inscripción como voluntario en la inciativa: ' + @volunteer.proyecto.titulo)
  end
end
