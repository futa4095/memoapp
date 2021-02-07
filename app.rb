# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'securerandom'

MEMO_FILE = './memo.dat'
DEFAULT_HEADERS = { 'Content-Security-Policy' => "default-src 'self'" }.freeze

memos = if File.exist?(MEMO_FILE)
          File.open(MEMO_FILE) { |f| JSON.parse(f.read) }
        else
          {}
        end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

after do
  headers DEFAULT_HEADERS
end

get '/' do
  redirect to('/memos')
end

get '/memos' do
  @memos = memos
  erb :top
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  new_memo = { 'title' => params[:title], 'body' => params[:body] }
  id = SecureRandom.uuid
  memos[id] = new_memo
  File.open(MEMO_FILE, 'w') do |f|
    JSON.dump(memos, f)
  end
  redirect to('/memos')
end

get '/memos/:id' do |id|
  pass unless memos.key?(id)
  @id = id
  @memo = memos[id]
  erb :show
end

get '/memos/:id/edit' do |id|
  pass unless memos.key?(id)
  @id = id
  @memo = memos[id]
  erb :edit
end

patch '/memos/:id' do |id|
  pass unless memos.key?(id)
  memo = { 'title' => params[:title], 'body' => params[:body] }
  memos[id] = memo
  File.open(MEMO_FILE, 'w') do |f|
    JSON.dump(memos, f)
  end
  redirect to('/memos')
end

delete '/memos/:id' do |id|
  pass unless memos.key?(id)
  memos.delete(id)
  redirect to('/memos')
end

not_found do
  erb :not_found
end
