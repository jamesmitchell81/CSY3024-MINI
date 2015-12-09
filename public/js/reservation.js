(function(win, doc) {

var requiredSeatsBox = doc.querySelectorAll('#required-seats input');

for ( var i = 0; i < requiredSeatsBox.length; i++ )
{
  requiredSeatsBox[i].addEventListener('click', getAvailableVehicles, false);
}

function getDates()
{
  var fromDate = doc.getElementById("departuredate").value;
  var toDate = doc.getElementById("returndate").value;

  from = new Date(fromDate);
  to = new Date(toDate);

  return {
    'from' :  from.getFullYear() + "-" + from.getMonth() + "-" + from.getDate(),
    'to'   :  to.getFullYear() + "-" + to.getMonth() + "-" + to.getDate()
  }
}

function getAvailableVehicles(e)
{
  var src = e.target || e.srcElement;
  var seats = src.getAttribute('value');
  var dates = getDates();
  var href = "/vehicles/" + seats + "/available/" + dates['from'] + "/" + dates['to'];
  // make the call
  ajax.get(href, function(data) {
    var stickTo = doc.getElementById("vehicle-selection");
    stickTo.innerHTML = data;
  });
}

} (window, document))