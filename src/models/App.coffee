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
    playerScore = (@get 'playerHand').currentScore
    dealerScore = (@get 'dealerHand').currentScore
    dealerScore = if dealerScore < 22 then dealerScore else 0

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
      hand.trigger 'stand'

    if hand.scores()[1] > 21
      while hand.scores()[0] < 17
        hand.hit()




    #flip card of dealer

    #calculate score
      #if and while dealer score < 17 then dealer.hit()
      #if dealerHand >=17 trigger stand
      #if dealerscore > 21 @trigger 'bust'
