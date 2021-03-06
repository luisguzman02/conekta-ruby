module Conekta
  class PayoutMethod < Resource
    include Conekta::Operations::Delete
    include Conekta::Operations::Update
    include Conekta::Operations::CustomAction
    def _url
      raise Error.new(
        I18n.t('error.resource.id',  { resource: self.class.class_name, locale: :en }),
        I18n.t('error.resource.id_purchaser',  { locale: Conekta.locale.to_sym })) if (id.nil? || id.empty?)
      self.payee._url + self.class._url + "/" + id
    end
    def delete
      self.delete_member('payee','payout_methods')
    end
  end
end
