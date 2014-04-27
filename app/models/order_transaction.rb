class OrderTransaction < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  serialize :params

  #validates :user, presence: true Se quita desde que las donaciones pueden ser anónimas

  def aportacion
    amount/100
  end

  def response=(response)
    self.success = response.success?
    self.authorization = response.authorization
    self.message = response.message
    self.params = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success = false
    self.authorization = nil
    self.message = e.message
    self.params = {}
  end

end
