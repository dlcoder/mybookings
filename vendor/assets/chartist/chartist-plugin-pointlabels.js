function ctLineLabels(options) {
  return function ctBarLabels(chart) {
    var defaultOptions = {
      labelClass: 'ct-label',
      labelOffset: {
        x: 0,
        y: -10
      },
      textAnchor: 'middle',
      labelInterpolationFnc: Chartist.noop
    };

    options = Chartist.extend({}, defaultOptions, options);

    if(chart instanceof Chartist.Line) {
      chart.on('draw', function(data) {
        if(data.type === 'point') {
          data.group.elem('text', {
            x: data.x + options.labelOffset.x,
            y: data.y + options.labelOffset.y,
            style: 'text-anchor: ' + options.textAnchor
          }, options.labelClass).text(options.labelInterpolationFnc(data.value.x === undefined ? data.value.y : data.value.x + ', ' + data.value.y));
        }
      });
    }
  }
}
