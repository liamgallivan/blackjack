class window.CardView extends Backbone.View
  className: 'card'

  template: _.template ''

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    suitName = (@model.get 'suitName').toLowerCase()
    rankName = @model.get 'rankName'
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get 'revealed'
      @$el.css({'background-image': 'url(\'./img/cards/'+rankName+'-'+suitName+'.png\')'})

#background-image: url('../img/cards/5-diamonds.png')
