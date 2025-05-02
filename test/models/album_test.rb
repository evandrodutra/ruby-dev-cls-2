require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test 'valid album' do
    album = Album.new(name: 'Peligro', players: [players(:shakira)])
    assert album.valid?
  end

  test 'presence of name' do
    album = Album.new
    assert_not album.valid?
    assert_not_empty album.errors[:name]
  end

  test 'presence of player' do
    album = Album.new
    assert_not album.valid?
    assert_not_empty album.errors[:players]
  end

  test 'album can have multiple players' do
    madonna = Player.create!(name: 'Madonna')
    shakira = Player.create!(name: 'Shakira')
    album = Album.create!(name: 'Collaboration Album', players: [madonna, shakira])

    assert_equal 2, album.players.count
    assert_includes album.players, madonna
    assert_includes album.players, shakira
  end

  test 'album requires a name' do
    album = Album.new
    assert_not album.valid?
    assert_includes album.errors[:name], "can't be blank"
  end
end
