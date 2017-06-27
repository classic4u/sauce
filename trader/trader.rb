require 'coinbase/exchange'

# let's be 90% sure or greater before we do anything
CONFIDENCE_LIMIT = 0.9
LIQUIDITY_MAXIMUM = 0.25

# Trader.trade

class Trader
  def self.trade
    trader = Trader.new

    trader.clear_open_orders

    trader.make_trade
  end

  def initialize
    @ltc = get_held_ltc
    @usd = get_held_usd
    @rest_api = CoinBase::Exchange::Client.new(api_key, api_secret, api_password)
  end

  def clear_open_orders
    @rest_api.orders(status: open) do |response|
      response.each { |order| @rest_api.cancel(order.id) }
    end
  end

  def make_trade
    if category == 'BEAR' && confidence >= CONFIDENCE_LIMIT
      make_ask
    end

    if category == 'BULL' && confidence >= CONFIDENCE_LIMIT
      make_bid
    end
  end

  private

  def get_held_ltc
    @rest_api.account_history(LTC_ACCOUNT_ID) do |response|
      puts response
    end
  end

  def get_held_usd
    @rest_api.account_history(USD_ACCOUNT_ID) do |response|
      puts response
    end
  end

  def make_ask
  end

  def make_bid
  end
end
