module UsersHelper

  def generate_activation_code(length = 20)
    (36**(length-1) + rand(36**length - 36**(length-1))).to_s(36)
  end

end
