$(function() {

function debounce(fn, timeout, ctx) {
    var timer;
    return function() {
        var args = arguments;
        ctx = ctx || this;
        clearTimeout(timer);
        timer = setTimeout(function() {
            fn.apply(ctx, args);
            timer = null;
        }, timeout);
    };
}

$('.event_place').map(function() {
    var $input = $(this).find('input'),
        address,
        $map = $(this).next('.event-map'),
        $location = $('#event_location'),
        coords = $location.val().split(',').map(Number),
        myMap;

    var id = 'm' + Math.random();
    $map.attr('id', id);

    ymaps.ready(function() {
        myMap = new ymaps.Map(id, {
            center: coords || [56.326887, 44.005986], // координаты центра НиНо
            zoom: 9,
            controls: ['smallMapDefaultSet']
        });
        coords.length && addPlacemark(coords);
    });

    $input.on('change keyup paste', debounce(function() {
        address = $input.val();
        ymaps.geocode(address, {
            kind: 'house',
            results: 1
        }).then(function(res) {
            var coords = res.geoObjects.get(0).geometry.getCoordinates();
            addPlacemark(coords);
            $location.val(coords.join());
        });
    }, 300));

    function addPlacemark(coords) {
        var placemark = new ymaps.Placemark(coords, {}, { draggable: true });
        myMap.geoObjects.removeAll();
        myMap.geoObjects.add(placemark);
        myMap.setCenter(coords);
        placemark.events.add('dragend', function() {
            $location.val(placemark.geometry.getCoordinates().join());
        });
    }
});

$('.event-place').map(function() {
    var $link = $(this).find('a'),
        address = $link.html(),
        coords = ($link.attr('data-location') || '').split(',').map(Number),
        $map = $(this).find('.event-map');

    coords.length === 2 && coords[0] && coords[1] || (coords = null);

    $link.click(function(e) {
        $map.toggleClass('visible');
        $map.inited || init($map);
        return false;
    });

    function init($map) {
        var id = 'm' + Math.random();
        $map.attr('id', id);

        var myMap = new ymaps.Map(id, {
                center: coords || [56.326887, 44.005986], // координаты центра НиНо
                zoom: 9,
                controls: ['smallMapDefaultSet']
            });

        if (coords) {
            myMap.geoObjects.add(
                new ymaps.Placemark(
                        coords,
                        { balloonContent: address },
                        { preset: 'islands#icon' }
                    ));
        } else {
            ymaps.geocode(address, {
                kind: 'house',
                results: 1
            }).then(function(res) {
                var firstGeoObject = res.geoObjects.get(0),
                    coords = firstGeoObject.geometry.getCoordinates(),
                    bounds = firstGeoObject.properties.get('boundedBy');

                myMap.geoObjects.add(firstGeoObject);
                myMap.setBounds(bounds, { checkZoomRange: true });
            });
        }

        $map.inited = true;
    }
});

});
