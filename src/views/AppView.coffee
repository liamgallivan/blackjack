class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .replay': ->
      $('body').empty()
      new AppView(model: new App()).$el.appendTo 'body'

      $('body').append($('<div class="deck"></div>'))

  initialize: ->
    @model.on 'playerWin', @playerWin, @
    @model.on 'dealerWin', @dealerWin, @
    @model.on 'draw', @draw, @

    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  dealerWin: ->
    console.log 'dealer win'
    @$el.append ($ '<h3>You Lose...</h3><button class="replay">Play Again?</button>')
    # display dealer wins
    $('.stand-button').toggle()
    $('.hit-button').toggle()

    #option for new game
  playerWin: ->
    console.log 'player win'
    @$el.append ($ '<h3>You Win!</h3><button class="replay">Play Again?</button>')
    $('.stand-button').toggle()
    $('.hit-button').toggle()
    # display Player Wins
    # start new game
  draw: ->
    console.log 'draw'
    @$el.append ($ '<h3>Draw! :O</h3><button class="replay">Play Again?</button>')
    $('.stand-button').toggle()
    $('.hit-button').toggle()
