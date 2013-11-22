require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Usps
      class PriorityMail < Calculator::Usps::Base

        def available?(order)
          # Override default; support this!
          exclusive_priority_shipping?(order) || super
        end

        def compute(object)

          result = super
          return result unless object.is_a?(Spree::Order)

          insurance_fee = 3.05

          unless result.nil?
            if exclusive_priority_shipping?(object)
              result + insurance_fee
            else
              result
            end
          end
        end

        def self.service_code
          1 #Priority Mail {0}™
        end

        def self.description
          I18n.t("usps.priority_mail")
        end
      end
    end
  end
end
