# Done by Inventos Digitais Ltda. and changed by Rodrigo F. Amorim

class TheFlashMessage
  message: $('.the-flash-message')
  fadeOut: 5000

  show: (type, msg, options = {})->
    options = $.extend(
      {
        fadeOut: @fadeOut
      },
      options
    )

    if type == 'success' or type == 'notice'
      @createTheFlash('success', msg, @fadeOut)
    else if type == 'warning'
      @createTheFlash('warning', msg, @fadeOut)
    else
      @createTheFlash('error', msg, @fadeOut)

  createTheFlash: (type, msg, fadeOut)->
    flash_message = $('<div>').addClass('the-flash-message-body ' +  type).append(
      $('<p>').html(msg)
      $('<i>').addClass('fa fa-times close')
    )

    if $('.the-flash-message').length > 0
      $('.the-flash-message').append(flash_message)
    else
      $('body').append(
        $('<div>').addClass('the-flash-message container').append(flash_message)
      )

    distance = (flash_message.offset().top) + 90
    flash_message.css({transform: 'translateY('+ - distance + 'px)'})
    # flash_message.css({'margin-top': ''+ -distance + 'px'})

    @animateOnShow(flash_message)
    @closeTheFlash(flash_message)
    @destroyOverTime(flash_message, fadeOut)

  animateOnShow: (elem)->

    run = ->
      elem.css({opacity: '1', transform: 'translateY(0px)'})
    # elem.css({opacity: '1', 'margin-top': '0px'})
    setTimeout(run, 300)

  animateOnExit: (elem)->

    distance = (elem.offset().top) + 90
    run = ->
      elem.css({opacity: '0', transform: 'translateY('+ - distance + 'px)'})
    # elem.css({opacity: '0', 'margin-top': '' + -distance + 'px'})

    setTimeout(run, 100, @destroyTheFlash(elem))

  closeTheFlash: (elem)->
    elem.click =>
      @animateOnExit(elem)

  destroyTheFlash: (elem)->
    run = ->
      elem.remove()
      if $('.the-flash-message').is(':empty')
        $('.the-flash-message').remove()
    setTimeout(run, 500)

  destroyOverTime: (elem, fadeOut)->
    run = =>
      @animateOnExit(elem)
    setTimeout(run, fadeOut)

@TheFlashMessage = new TheFlashMessage()