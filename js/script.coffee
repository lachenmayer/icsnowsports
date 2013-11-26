moveOnScroll = ($container, $image, amount, property) ->
  $(window).scroll ->
    scrollCoefficient = (($container.offset().top + $container.height()) - $(window).scrollTop()) / (window.innerHeight + $container.height())
    if 0 < scrollCoefficient < 1
      $image.css property, scrollCoefficient * amount

verticalParallax = ($containers) ->
  for container in $containers
    parallax $(container), 'height', 'top'

horizontalParallax = ($containers) ->
  for container in $containers
    parallax $(container), 'width', 'left'

# measure: 'width' or 'height'
# property: 'top' or 'left'
parallax = ($container, measure, property) ->
  containerMeasure = $container[measure]()
  $container.find('img').load (evt) ->
    $image = $(evt.currentTarget)
    imgMeasure = $image[measure]()
    difference = containerMeasure - imgMeasure
    moveOnScroll $container, $image, difference, property

$ ->
    verticalParallax $('.vertical')
    horizontalParallax $('.horizontal')