# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'bust', @dealerWin, @# need to trigger
    (@get 'dealerHand').on 'bust', @playerWin, @
    (@get 'playerHand').on 'stand', @dealerTurn, @

    (@get 'dealerHand').on 'stand', @resolveGame, @
  resolveGame: ->
    #playerScore take best score from playerHand
    player = @get 'playerHand'
    playerScore = if player.scores()[0] < player.scores()[1] and player.scores()[1] < 22 then player.scores()[0] else player.scores()[1]
    #dealerScore take best score from dealerHand
    dealer = @get 'dealerHand'
    dealerScore = if dealer.scores()[0] < dealer.scores()[1] and dealer.scores()[1] < 22 then dealer.scores()[0] else dealer.scores()[1]
    console.log playerScore, dealerScore
    #if dealerScore > dealerScore then @trigger playerWin else dealerWin
    if dealerScore == playerScore then @draw() else
      if dealerScore > playerScore then @dealerWin() else @playerWin()

  draw: ->
    @trigger 'draw'
  playerWin: ->
    @trigger 'playerWin'
  dealerWin: ->
    @trigger 'dealerWin'
  dealerTurn: ->
    hand =  @get 'dealerHand'
    (hand.at 0).flip()
    if hand.scores()[1] < 22
      while hand.scores()[1] < 17
        hand.hit()
    if hand.scores()[1] > 21
      while hand.scores()[0] < 17
        hand.hit()
    hand.trigger 'stand'




    #flip card of dealer

    #calculate score
      #if and while dealer score < 17 then dealer.hit()
      #if dealerHand >=17 trigger stand
      #if dealerscore > 21 @trigger 'bust'
