class window.AppView extends Backbone.View
  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class ="stand"></div>
    <div class ="deck"></div>
    <div class="back"></div>
  '

  events:
    'click .deck': -> @model.get('playerHand').hit()
    'click .stand': -> @model.get('playerHand').stand()
    'click .link': -> console.log('hey');
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
    # alert 'dealer win'
    @$el.append ($ '<div>You Lose...</div><button class="replay">Play Again?</button>')
    $('.stand').click( -> return false)
    $('.deck').click( ->  return false)

    #option for new game
  playerWin: ->
    # alert 'player win'
    @$el.append ($ '<div>You Win!</div><button class="replay">Play Again?</button>')
    $('.stand').click( -> return false)
    $('.deck').click( ->  return false)

  draw: ->
    console.log 'draw'
    @$el.append ($ '<div>Draw! :O</div><button class="replay">Play Again?</button>')
    $('.stand').click( -> return false)
    $('.deck').click( ->  return false)
