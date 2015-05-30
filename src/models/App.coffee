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
    # (@get 'dealerHand').on 'blackJack', @dealerWin, @
    # (@get 'playerHand').on 'blackJack', @playerWin, @

  resolveGame: ->
    #playerScore take best score from playerHand
    playerScore = (@get 'playerHand').currentScore
    dealerScore = (@get 'dealerHand').currentScore
    if dealerScore > 21 then return

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
    currentScore = hand.getScore()
    if currentScore < 22
      while currentScore < 17
        hand.hit()
        currentScore = hand.getScore()
      hand.trigger 'stand'





    #flip card of dealer

    #calculate score
      #if and while dealer score < 17 then dealer.hit()
      #if dealerHand >=17 trigger stand
      #if dealerscore > 21 @trigger 'bust'
