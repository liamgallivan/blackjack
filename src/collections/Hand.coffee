class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
  currentScore: 0
  hit: ->
    @add(@deck.pop())
    @getScore()
    if @scores()[0] == 21 or @scores()[1] == 21 then @trigger 'blackJack', @
    if @scores()[0] > 21 then @trigger 'bust', @

  stand: ->
    @getScore()
    @trigger 'stand'

  getScore: ->
    if @scores()[0] < @scores()[1] and @scores()[1] < 22
      @currentScore = @scores()[0]
    else
      @currentScore = @scores()[1]

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

