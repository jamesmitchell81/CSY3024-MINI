(function(win, doc) {

var requiredSeatsBox = doc.querySelectorAll('#required-seats input');

for ( var i = 0; i < requiredSeatsBox.length; i++ )
{
  requiredSeatsBox[i].addEventListener('click', getAvailableVehicles, false);
}

function getDates()
{
  var fromDate = doc.getElementById("departure-date").value;
  var fromTime = doc.getElementById("departure-time").value;
  var toDate = doc.getElementById("return-date").value;
  var toTime = doc.getElementById("return-time").value;

  from = new Date(fromDate + "T" + fromTime);
  to = new Date(toDate + "T" + toTime);
  return {
    'from' :  from.getFullYear() + "-" + from.getMonth() + "-" + from.getDate(),
    'to'   :  to
  }
}

function getAvailableVehicles(e)
{
  var src = e.target || e.srcElement;
  var seats = src.getAttribute('data-value');
  var dates = getDates();
  var href = "/vehicles/" + seats + "/available/" + dates['from'] + "/" + dates['to'];
  // check the dates are input.

  console.log(href);

  // make the call
  ajax.get(href, function(data) {

  });
}

} (window, document))