class ProviderMailer < ApplicationMailer
  default from: ENV['MAILJET_EMAIL']

  def orders_mail(custom_text, orders)
    @custom_text = custom_text
    @wines_with_orders = orders.group_by(&:wine)
    @total = orders.sum(&:full_price)

    mail(
      to: ENV['MAILJET_PROVIDER_EMAIL'],
      cc: ENV['MAILJET_EMAIL'],
      subject: "Bestellung #{Date.today.strftime('%d.%m.%y')}"
    )
  end
end
