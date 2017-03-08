# Done by Inventos Digitais Ltda. and changed by Rodrigo F. Amorim

#= require spin.min

class Loading
  opts: {
    lines: 15
    length: 15
    width: 7
    radius: 35
    scale: 1
    corners: 1
    color: '#fff'
    opacity: 0.1
    rotate: 0
    direction: 1
    speed: 0.7
    trail: 100
    fps: 20
    zIndex: 2e9
    className: 'spinner'
    top: '50%'
    left: '50%'
    shadow: false
    hwaccel: false
    position: 'absolute'
  }

  overlay: $('<div>').attr('id':'loading_overlay').css({
    'width': '100%',
    'height': '100%',
    'position': 'fixed',
    'z-index': '1000000',
    'background-color': 'rgba(0,0,0,0.7)',
    'top': '0',
    'left': '0'
  })

  constructor: ->
    spinner = new Spinner(@opts).spin()

    $('body').prepend @overlay
    @overlay.append(spinner.el)

    $('.spinner').css
      left : '50%'
      top : '50%'

    @overlay.hide()

  start_loading: ->
    @overlay.fadeIn('fast')

  stop_loading: ->
    @overlay.fadeOut('fast')

$ =>
  @Loading = new Loading()
