/**
 * Created by frasiek on 2015-02-02.
 */
//= require excanvas.min
//= require jquery.jqplot.min
//= require plugins/jqplot.canvasAxisLabelRenderer.min.js
//= require plugins/jqplot.canvasTextRenderer.min.js
//= require plugins/jqplot.highlighter.min.js
//= require plugins/jqplot.cursor.min.js
//= require plugins/jqplot.dateAxisRenderer.min.js
//= require plugins/jqplot.enhancedLegendRenderer.min.js
//= require plugins/jqplot.pieRenderer.min.js

$(document).ready(function () {
    var diagramObj = null
    $(document).on("submit", "form#filters", function (event) {
        event.preventDefault();
        var type = $("[data-type]").attr("data-type");
        $.post("/report/data.json", {type: type, filters: $(this).serialize()}, function (response) {
            if (diagramObj === null) {
                diagramObj = new diagram(type, response);
            } else {
                diagramObj.setData(response)
            }
            diagramObj.draw();
        }, 'json');
        return false;
    });
});

function diagram(type, data) {
    this.type = type;
    this.data = data;
}

diagram.prototype.setData = function (data) {
    this.data = data;
}

diagram.prototype.clear = function (data) {
    $("#chart").html("");
}

diagram.prototype.draw = function () {
    this.clear();
    var data = null;
    if (this.type == 'line') {
        data = this.prepareDataLine();
    } else {
        data = this.prepareDataPie();
    }
    this._draw(data[0], data[1]);
}

diagram.prototype.prepareDataLine = function () {
    var series = new Array();
    var series_titles = new Array();
    var return_array = new Array();
    $.each(this.data, function (indx, item) {
        if (typeof series[item[1]] != "object") {
            series_titles.push({
                "label": item[1],
                lineWidth: 4
            });
            series[item[1]] = new Array();
        }
        series[item[1]].push([item[2], item[0] * 1]);
    });
    $.each(series_titles, function (i, item) {
        return_array.push(series[item.label]);
    });
    return [return_array, series_titles];
}

diagram.prototype.prepareDataPie = function () {
    var series = new Array();
    var series_titles = new Array();
    $.each(this.data, function (indx, item) {
        var title = item[1];
        var value = item[0]*1;
        var set = false;
        $.each(series, function(i, item){
            if(item[0] == title){
                series[i][1]+=value;
                set = true;
            }
        });
        if(!set){
            series.push([title, value]);
        }
    });
    return [series, []];
}

diagram.prototype._draw = function (data, series) {
    if (this.type == 'line') {
        this.plot = $.jqplot("chart", data, {
            series: series,
            axes: {
                xaxis: {
                    renderer: $.jqplot.DateAxisRenderer,
                    tickOptions: {
                        formatString: '%b&nbsp;%#d'
                    }
                },
                yaxis: {
                    tickOptions: {
                        formatString: '%.2fzł'
                    }
                }
            },
            highlighter: {
                show: true,
                sizeAdjust: 7.5
            },
            cursor: {
                show: false,
                tooltipLocation:'sw',
                zoom:true
            },
            legend: {
                renderer: $.jqplot.EnhancedLegendRenderer,
                show: true
            }
        });
    } else {
        this.plot = $.jqplot ('chart', [data],
            {
                seriesDefaults: {
                    // Make this a pie chart.
                    renderer: jQuery.jqplot.PieRenderer,
                    rendererOptions: {
                        // Put data labels on the pie slices.
                        // By default, labels show the percentage of the slice.
                        showDataLabels: true
                    }
                },
                legend: { show:true, location: 'e' }
            }
        );
    }
}