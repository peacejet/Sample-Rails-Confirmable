module Confirmable
  extend ActiveSupport::Concern

  included do
    # validation
    validates :name, presence: true
    validates :email, presence: true
    validates :memo, presence: true

    # new -> confirm
    validates :submitted, acceptance: true
    # confirm -> create
    validates :confirmed, acceptance: true

    after_validation :confirming

    private

    def confirming
      if submitted == ''
        self.submitted = errors.include?(:submitted) && errors.size == 1 ? '1' : ''
      end

      if confirmed == ''
        self.submitted = nil
        self.confirmed = nil
      end

      errors.delete :submitted
      errors.delete :confirmed
    end
  end
end
