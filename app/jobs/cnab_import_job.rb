class CnabImportJob < ApplicationJob
  queue_as :default

  def perform(cnab)
    cnab.parse
    Order.save_from_cnab_content(cnab.content)
  end
end
