# frozen_string_literal: true

class UpdateEventPageviews
  attr_reader :events, :credentials, :token, :urls, :ga_data

  def self.perform
    Event.find_in_batches(batch_size: 100) do |events|
      instance = new(events)
      instance.update_pageviews!
    end
  end

  def initialize(events)
    @events = events
    @credentials = Rails.application.credentials.google_api
    @token = get_oauth_token
    get_ga_data!
  end

  def update_pageviews!
    ga_data.each_with_index do |row, _index|
      value = row['metrics'][0]['values'][0]
      slug = row['dimensions'][0].split('/')[2]
      Event.find_by(slug: slug).update(pageviews: value)
    end
  end

  private

  def get_ga_data!
    url = 'https://analyticsreporting.googleapis.com/v4/reports:batchGet'
    headers = { 'Authorization' => "Bearer #{token}" }
    @urls = events.map { |event| Rails.application.routes.url_helpers.event_path(event) }
    response = Excon.post(url, body: build_request_body(urls), headers: headers)
    @ga_data = extract_data(response)
  end

  def get_oauth_token
    body = URI.encode_www_form(
      grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      assertion: build_jwt_token
    )
    headers = { 'Content-Type' => 'application/x-www-form-urlencoded' }
    response = Excon.post(credentials[:token_uri], body: body, headers: headers)
    JSON.parse(response.body)['access_token']
  end

  def build_jwt_token
    time = Time.current
    key = OpenSSL::PKey::RSA.new(credentials[:private_key])
    payload = {
      iss: credentials[:client_email],
      scope: 'https://www.googleapis.com/auth/analytics.readonly',
      aud: credentials[:token_uri],
      exp: (time + 1.hour).to_i,
      iat: time.to_i
    }
    JWT.encode(payload, key, 'RS256')
  end

  def build_request_body(urls = [])
    params = {
      reportRequests: [{
        viewId: '90699875',
        dimensions: [{ name: 'ga:pagePath' }],
        metrics: [{ expression: 'ga:pageviews' }],
        dimensionFilterClauses: [{
          filters: [{
            operator: 'IN_LIST',
            dimensionName: 'ga:pagePath',
            expressions: urls
          }]
        }],
        dateRanges: [{
          startDate: '2014-09-01',
          endDate: Time.current.strftime('%F')
        }]
      }]
    }
    params.to_json
  end

  def extract_data(response)
    JSON.parse(response.body)['reports'][0]['data']['rows']
  end
end
