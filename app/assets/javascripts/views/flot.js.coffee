Facture.FlotView = Ember.View.extend
  attributeBindings: ['style']
  style: "height: 400px"

  didInsertElement: ->
    @renderChart()

  chartUpdated: (->
    @renderChart()
  ).observes('datasets')

  renderChart: ->
    canvas = @$()
    if (canvas)
      canvas.plot(
        @get('datasets'), {
        bars:
          show: true
          fill: true
          barWidth: 60*60*24*20*1000
          align: 'center'
          lineWidth: 0
          fillColor: '#75b9e6'
        grid:
          borderWidth: 0
          labelMargin: 20
        xaxis:
          mode: "time",
          timeformat: "%b %Y"
          tickSize: [1, "month"]
          tickLength: 0
        yaxis:
          tickLength: 0
      })