# frozen_string_literal: true

require 'pg'

class MemoStore
  def initialize
    @connection = PG::Connection.new(dbname: 'futa4095memoapp')
    @connection.prepare('select memo', 'SELECT id, title, body FROM memo WHERE id = $1')
    @connection.prepare('insert memo', 'INSERT INTO memo(title, body) values($1, $2)')
    @connection.prepare('update memo', 'UPDATE memo SET title = $1, body = $2 WHERE id = $3')
    @connection.prepare('delete memo', 'DELETE FROM memo WHERE id = $1')
  end

  def list
    @connection.exec('SELECT id, title FROM memo ORDER BY id')
  end

  def key?(id:)
    find(id: id).ntuples == 1
  end

  def find(id:)
    @connection.exec_prepared('select memo', [id])
  end

  def add(memo)
    @connection.exec_prepared('insert memo', [memo['title'], memo['body']])
  end

  def update(memo)
    @connection.exec_prepared('update memo', [memo['title'], memo['body'], memo['id']])
  end

  def remove(id:)
    @connection.exec_prepared('delete memo', [id])
  end
end
