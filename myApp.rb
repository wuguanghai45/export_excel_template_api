require 'sinatra'
require "json"
require File.expand_path(File.dirname(__FILE__) + '/lib/convert_to_excel')

post '/export' do
  @path = params[:path]
  results = ConvertToExcel.new(@path, JSON.generate(params[:object])).process
  content_type :json
  { success: true, filepath: results.first }.to_json
end
