# frozen_string_literal: true

require 'sinatra'
require 'net/http'
require 'uri'
require 'json'

get '/' do
  erb :form
end

# TODO: select box for issue type
post '/form' do
  uri = URI.parse('https://company_name.jira.com/rest/api/2/issue/')
  replicate = params['can_replicate'] == '0' ? 'no' : 'yes'
  json = {
    'fields' => {
      'project' => { 'key' => ENV['PROJECT_KEY'] },
      'summary' => params['title'],
      'description' => "Description: #{params['description']}\n\n"\
                       "Source: #{params['source']}\n\n"\
                       "Able to replicate? #{replicate}\n\n"\
                       "Steps: #{params['steps']}\n\n"\
                       "Submitter Name: #{params['name']}",
      'issuetype' => { 'name' => 'Bug' }
    }
  }
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.request_uri,
                                'Content-Type' => 'application/json')
  request.body = json.to_json
  request.basic_auth(ENV['JIRA_USERNAME'], ENV['JIRA_PASSWORD'])
  response = http.request(request)
  parsed_request = JSON.parse(response.body)
  erb :response, locals: { key: parsed_request['key'] }
end
