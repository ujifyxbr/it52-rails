(function () {
    'use strict';

    angular.module('map').service('Placemark', ['$q', '$http', function ($q, $http) {
        var STUB = [{
            lng: 44.006265,
            lat: 56.322584,
            layer: 'company',
            message: "Yandex",
            icon: {
                type: 'extraMarker',
                icon: 'fa-beer',
                markerColor: 'red',
                prefix: 'fa',
                shape: 'star'
            }
        }, {
            lng: 43.994991,
            lat: 56.330452,
            layer: 'company',
            message: "SmartBICS",
            icon: {
                type: 'extraMarker',
                icon: 'fa-gear',
                markerColor: 'yellow',
                prefix: 'fa',
                shape: 'star'
            }
        },
            {
                lng: 43.998665,
                lat: 56.288137,
                layer: 'event',
                message: "MeteorJS",
                icon: {
                    type: 'extraMarker',
                    icon: 'fa-calendar',
                    markerColor: 'green',
                    prefix: 'fa'
                }
            },
            {
                lng: 44.006265,
                lat: 56.322584,
                layer: 'event',
                message: "Frontend hackathon",
                icon: {
                    type: 'extraMarker',
                    icon: 'fa-calendar',
                    markerColor: 'green',
                    prefix: 'fa'
                }
            }
        ];
        var eventUrl = 'http://www.it52.info/api/v1/events?callback=JSON_CALLBACK';
        var oneEventUrl = 'http://www.it52.info/api/v1/events/{0}?callback=JSON_CALLBACK';

        function formatPlacemarks(result) {
            return result.data.map(function (placemark) {
                return {
                    lng: placemark.location ? 0 : 44.006265,
                    lat: placemark.location ? 0 : 56.322584,
                    layer: 'event',
                    message: placemark.title,
                    placemarkId: placemark.id,
                    icon: {
                        type: 'extraMarker',
                        icon: 'fa-calendar',
                        markerColor: 'green',
                        prefix: 'fa'
                    }
                };
            })
        }

        function loadAll() {
            return $http.jsonp(eventUrl).then(function (result) {
                return formatPlacemarks(result);
            })
        }

        return {

            getPlacemarks: function () {

                //return $q.when(STUB);
                return loadAll();
            },
            getPlacemark: function (id) {
                var url = oneEventUrl.replace('{0}', id);
                return $http.jsonp(url);
            }

        };
    }]);
}());