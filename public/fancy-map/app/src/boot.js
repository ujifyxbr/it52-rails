/*
*  Starting point of your app
*/
(function(){
'use strict';

  angular
      .module('it52.info', ['ngMaterial', 'ui.router','leaflet-directive', 'map', 'menu', 'ng-mfb'])
      .config( function($mdThemingProvider, $mdIconProvider, $stateProvider, $urlRouterProvider) {

          $mdIconProvider
              .defaultIconSet("assets/svg/avatars.svg", 128 )
              .icon("menu", "assets/svg/ic_menu_24px.svg", 24);


          // Use the 'brown' theme - override default 'blue' theme
          $mdThemingProvider.theme('default')
              .primaryPalette('blue-grey')
              .accentPalette('grey');

          $urlRouterProvider.otherwise('/');

          $stateProvider

               .state('map', {
                  url:'/',
                  templateUrl: 'src/map/map.html',
                  controller: 'MapController'
              })
              .state('calendar', {
                  templateUrl: 'src/stub/notImplemented.html'
              })
              .state('home', {
                  templateUrl: 'src/stub/notImplemented.html'
              });

      });

})();
