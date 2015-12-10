(function(win, doc) {

var requiredSeatsBox = doc.querySelectorAll('#required-seats input');
var fromDate = doc.getElementById("departuredate");
var toDate = doc.getElementById("returndate");

fromDate.addEventListener('change', getAvailableVehicles, false);
toDate.addEventListener('change', getAvailableVehicles, false);

for ( var i = 0; i < requiredSeatsBox.length; i++ )
{
  requiredSeatsBox[i].addEventListener('click', getAvailableVehicles, false);
}

function getDates()
{
  from = new Date(fromDate.value);
  to = new Date(toDate.value);

  return {
    'from' :  from.getFullYear() + "-" + (from.getMonth() + 1) + "-" + from.getDate(),
    'to'   :  to.getFullYear() + "-" + (to.getMonth() + 1) + "-" + to.getDate()
  }
}

function seatsValue() {
  for ( var i = 0; i < requiredSeatsBox.length; i++ ) {
    if ( requiredSeatsBox[i].checked ) {
      return requiredSeatsBox[i].getAttribute("value");
    }
  }
}

function getAvailableVehicles() {
  var seats = seatsValue();
  var dates = getDates();
  var href = "/vehicles/" + seats + "/available/" + dates['from'] + "/" + dates['to'];

  ajax.get(href, function(data) {
    var stickTo = doc.getElementById("vehicle-selection");
    stickTo.innerHTML = data;
  });
}

} (window, document))