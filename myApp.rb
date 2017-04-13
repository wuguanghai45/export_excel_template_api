require 'sinatra'
require "json"
require File.expand_path(File.dirname(__FILE__) + '/lib/convert_to_excel')

post '/' do
  @path = params[:template][:tempfile]
  results = ConvertToExcel.new(@path, params[:data]).process
  send_file results.first, filename: "Customers.xls"
end
