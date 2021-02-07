# frozen_string_literal: true

require 'sinatra'
require 'json'
require './lib/memo_store'

MEMO_FILE = './memo.dat'
DEFAULT_HEADERS = { 'Content-Security-Policy' => "default-src 'self'" }.freeze

memos = MemoStore.new

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
  @memos = memos.list
  erb :top
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  new_memo = { 'title' => params[:title], 'body' => params[:body] }
  memos.add(new_memo)
  redirect to('/memos')
end

get '/memos/:id' do |id|
  pass unless memos.key?(id: id)
  @memo = memos.find(id: id)[0]
  erb :show
end

get '/memos/:id/edit' do |id|
  pass unless memos.key?(id: id)
  @memo = memos.find(id: id)[0]
  erb :edit
end

patch '/memos/:id' do |id|
  pass unless memos.key?(id: id)
  memo = { 'id' => id, 'title' => params[:title], 'body' => params[:body] }
  memos.update(memo)
  redirect to('/memos')
end

delete '/memos/:id' do |id|
  pass unless memos.key?(id: id)
  memos.remove(id: id)
  redirect to('/memos')
end

not_found do
  erb :not_found
end
