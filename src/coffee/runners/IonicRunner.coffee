class IonicRunner extends Run
  constructor: ($ionicPlatform) ->
    $ionicPlatform.ready ->
      # Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
      # for form inputs)
      if window.cordova?.plugins?.Keyboard?
        window.cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)

      if window.StatusBar?
        window.StatusBar.styleDefault()
