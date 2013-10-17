moveOnScroll = ($container, $image, amount, property) ->
  $(window).scroll ->
    scrollCoefficient = (($container.offset().top + $container.height()) - $(window).scrollTop()) / (window.innerHeight + $container.height())
    if 0 < scrollCoefficient < 1
      $image.css property, scrollCoefficient * amount

verticalParallax = ($containers) ->
  for container in $containers
    $container = $(container)
    containerHeight = $container.height()
    $container.find('img').load (evt) ->
      $image = $(evt.currentTarget)
      imgHeight = $image.height()
      difference = containerHeight - imgHeight
      moveOnScroll $container, $image, difference, 'top'

horizontalParallax = ($containers) ->
  for container in $containers
    $container = $(container)
    containerWidth = $container.width()
    $container.find('img').load (evt) ->
      $image = $(evt.currentTarget)
      imgWidth = $image.width()
      difference = containerWidth - imgWidth
      moveOnScroll $container, $image, difference, 'left'


$ ->
    verticalParallax $('.vertical')
    # verticalParallax $('.horizontal')
    horizontalParallax $('.horizontal')