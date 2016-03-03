var BREW = {};

BREW.show = function(){
	$("#brewerytable tr:gt(0)").remove();

	var table = $("#brewerytable");

	$.each(BREW.list, function (index, brewery) {
        table.append('<tr>'
            +'<td>'+brewery['name']+'</td>'
            +'<td>'+brewery['year']+'</td>'
            +'</tr>');
    });
};

BREW.sort_by_name = function(){
    BREW.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREW.sort_by_year = function(){
    BREW.list.sort( function(a,b){
        return a.year.toString().localeCompare(b.year.toString());
    });
};

$(document).ready( function() {

	$("#brewname").click(function (e) {
        BREW.sort_by_name();
        BREW.show();
        e.preventDefault();
    });
    $("#year").click(function (e) {
        BREW.sort_by_year();
        BREW.show();
        e.preventDefault();
    });

	if ( $("#brewerytable").length>0 )
    $.getJSON('breweries.json', function (breweries) {
        BREW.list = breweries;
        BREW.sort_by_name();
        BREW.show();
    });
});