require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test 'valid player' do
    player = Player.new(name: 'Madonna')
    assert player.valid?
  end

  test 'presence of name' do
    player = Player.new
    assert_not player.valid?
    assert_not_empty player.errors[:name]
  end

  test 'player can have multiple albums' do
    madonna = Player.create!(name: 'Madonna')
    album1 = Album.create!(name: 'Album 1', players: [madonna])
    album2 = Album.create!(name: 'Album 2', players: [madonna])

    assert_equal 2, madonna.albums.count
    assert_includes madonna.albums, album1
    assert_includes madonna.albums, album2
  end

  test 'player requires a name' do
    player = Player.new
    assert_not player.valid?
    assert_includes player.errors[:name], "can't be blank"
  end

  test 'albums can be shared between players' do
    madonna = Player.create!(name: 'Madonna')
    shakira = Player.create!(name: 'Shakira')
    collaboration = Album.create!(name: 'Collaboration Album', players: [madonna, shakira])

    assert_includes madonna.albums, collaboration
    assert_includes shakira.albums, collaboration
    assert_equal 2, collaboration.players.count
  end
end
