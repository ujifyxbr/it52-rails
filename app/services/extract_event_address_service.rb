# frozen_string_literal: true

class ExtractEventAddressService
  def initialize(event)
    @event = event
  end

  def call
    suggestions = DaData::Request.suggest_address(@event.place)
    fias_id = suggestions['suggestions'][0]['data']['fias_id']
    data = DaData::Request.find_by_id(fias_id)
  end
end
