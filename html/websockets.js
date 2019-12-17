/* initialise variable */
var ws, matches = document.getElementById("div-table");

function connect() {
    if ("WebSocket" in window) {
       ws = new WebSocket("ws://localhost:5002");
        ws.onopen = function(e) {
            /* on successful connection, we want to create an
            initial subscription to load all the data into the page*/
            ws.send("loadPage[]");
        };

        ws.onmessage = function(e) {
            /*parse message from JSON String into Object*/
            var d = JSON.parse(e.data);
            /*depending on the messages func value, pass the result
            to the appropriate handler function*/
            switch(d.func){
            case 'getMatches' : setMatches(d.result); break;
	    case 'putMatchUpdate' : setMatchUpdate(d.result); break;
	    default: console.log(d);
            }
        };
        ws.onclose = function(e){ console.log("disconnected")};
        ws.onerror = function(e){ console.log(e.data)};
    } else alert("WebSockets not supported on your browser.");
}

function setMatchUpdate(data) {
    for (var i = 0; i < data.length; i++) {
	var match_id = data[i][0].match_id;
	var row = insertRowHTML(i, data[i]);
	var element = document.getElementById(match_id);
//	console.log(row);
	element.innerHTML = row;
    }
}

function insertRowHTML(i, data) {
    var rowHTML = '';
    /* loop through the rows, putting tags around each col value */
    rowHTML += '<div class="div-table-row" id='+ data[i]['match_id'] + '>';
    for (var x in data[0]) {
        /* Instead of pumping out the raw data to the table, let's
           format it according to its type*/
        var cellData;
        if("number" == typeof data[i][x])
            cellData = data[i][x].toFixed(2);
        else cellData = data[i][x];
        rowHTML += '<div class="div-table-col">' + cellData + '</div>';
    }
    rowHTML += '</div>';
    return rowHTML
}

function setMatches(data) { matches.innerHTML = generateTableHTML(data) }


function generateTableHTML(data){
    /* we will iterate through the object wrapping it in the HTML table tags */
    var tableHTML = '<div class="div-table-row">';
    for (var x in data[0]) {
        /* loop through the keys to create the table headers */
        tableHTML += '<div class="div-table-col" align="center">' + x + '</div>';
    }
    tableHTML += '</div>';
    for (var i = 0; i < data.length; i++) {
        /* loop through the rows, putting tags around each col value */
	tableHTML += insertRowHTML(i, data);
    }
    return tableHTML;
}
