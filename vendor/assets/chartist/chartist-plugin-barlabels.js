function ctBarLabels(options) {
  return function ctBarLabels(chart) {
    var defaultOptions = {
      labelClass: 'ct-label',
      labelOffset: {
        x: 0,
        y: -10
      },
      textAnchor: 'middle'
    };

    options = Chartist.extend({}, defaultOptions, options);

    if (chart instanceof Chartist.Bar) {
      chart.on('draw', function(data) {
        if (data.type === 'bar' && data.value.y != 0) {
          data.group.elem('text', {
            x: data.x2 + options.labelOffset.x,
            y: data.value.y > 0 ? data.y2 + options.labelOffset.y : data.y1 + options.labelOffset.y,
            style: 'text-anchor: ' + options.textAnchor
          }, options.labelClass).text(data.value.y);
        }
      });
    }
  }
}
