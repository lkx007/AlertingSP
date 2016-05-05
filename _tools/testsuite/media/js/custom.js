/* XXX multi filter select XXX */

(function($) {
  /*
   * Function: fnGetColumnData
   * Purpose:  Return an array of table values from a particular column.
   * Returns:  array string: 1d data array 
   * Inputs:   object:oSettings - dataTable settings object. This is always the last argument past to the function
   *           int:iColumn - the id of the column to extract the data from
   *           bool:bUnique - optional - if set to false duplicated values are not filtered out
   *           bool:bFiltered - optional - if set to false all the table data is used (not only the filtered)
   *           bool:bIgnoreEmpty - optional - if set to false empty values are not filtered from the result array
   * Author:   Benedikt Forchhammer <b.forchhammer /AT\ mind2.de>
   */
  $.fn.dataTableExt.oApi.fnGetColumnData = function ( oSettings, iColumn, bUnique, bFiltered, bIgnoreEmpty ) {
    // check that we have a column id
    if ( typeof iColumn == "undefined" ) return new Array();

    // by default we only want unique data
    if ( typeof bUnique == "undefined" ) bUnique = true;

    // by default we do want to only look at filtered data
    if ( typeof bFiltered == "undefined" ) bFiltered = true;

    // by default we do not want to include empty values
    if ( typeof bIgnoreEmpty == "undefined" ) bIgnoreEmpty = true;

    // list of rows which we're going to loop through
    var aiRows;

    // use only filtered rows
    if (bFiltered == true) aiRows = oSettings.aiDisplay; 
    // use all rows
    else aiRows = oSettings.aiDisplayMaster; // all row numbers

    // set up data array	
    var asResultData = new Array();

    for (var i=0,c=aiRows.length; i<c; i++) {
      iRow = aiRows[i];
      var aData = this.fnGetData(iRow);
      var sValue = aData[iColumn];

      // ignore empty values?
      if (bIgnoreEmpty == true && sValue.length == 0) continue;

      // ignore unique values?
      else if (bUnique == true && jQuery.inArray(sValue, asResultData) > -1) continue;

      // else push the value onto the result data array
      else asResultData.push(sValue);
    }

    return asResultData;
  }}(jQuery));


function fnCreateSelect( aData )
{
  var r='<select><option value=""></option>', i, iLen=aData.length;
  for ( i=0 ; i<iLen ; i++ )
  {
    r += '<option value="'+aData[i]+'">'+aData[i]+'</option>';
  }
  return r+'</select>';
}

/* XXX Row details XXX */

/* Formating function for row details */
function fnFormatDetails ( oTable, nTr )
{
  var aData = oTable.fnGetData( nTr );
  var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
  sOut += '<tr><td>'+aData[9]+'</td></tr>';
  sOut += '<tr><td>Result:</td><td>'+aData[4]+'</td></tr>';
  sOut += '<tr><td>File:</td><td>'+aData[6]+'</td></tr>';
  sOut += '<tr><td>Line:</td><td>'+aData[7]+'</td></tr>';
  sOut += '<tr><td>Message:</td><td>'+aData[8]+'</td></tr>';
  sOut += '</table>';

  return sOut;
}

/* XXX ready XXX */

$(document).ready(function() {
  /*
   * Insert a 'details' column to the table
   */
  var nCloneTh = document.createElement( 'th' );
  var nCloneTd = document.createElement( 'td' );
  nCloneTd.innerHTML = '<img src="../media/images/details_open.png">';
  nCloneTd.className = "center";

  $('#example thead tr').each( function () {
    this.insertBefore( nCloneTh, this.childNodes[0] );
  } );

  $('#example tbody tr').each( function () {
    this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[0] );
  } );

  /* Initialise the DataTable */
  var oTable = $('#example').dataTable( {
    "iDisplayLength": 25,
    "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
    "oLanguage": {
      "sSearch": "Search all columns:"
    },
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0 ] },
      { "bSortable": false, "bSearchable":false, "bVisible": false, "aTargets":[6]},
      { "bSortable": false, "bSearchable":false, "bVisible": false, "aTargets":[7]},
      { "bSortable": false, "bSearchable":false, "bVisible": false, "aTargets":[8]},
      { "bSortable": false, "bSearchable":false, "bVisible": false, "aTargets":[9]}
    ],
    "aaSorting": [[1, 'asc']]
  } );

  /* Add a select menu for each TH element in the table footer */
  //$("tfoot th").each( function ( i ) {
  $(".wantselect").each( function ( j ) {
    var i=j+1
    this.innerHTML = fnCreateSelect( oTable.fnGetColumnData(i) );
    $('select', this).change( function () {
      oTable.fnFilter( $(this).val(), i );
    } );
  } );

  /* Add event listener for opening and closing details
   * Note that the indicator for showing which row is open is not controlled by DataTables,
   * rather it is done here
   */
  $('#example tbody td img').live('click', function () {
    var nTr = $(this).parents('tr')[0];
    if ( oTable.fnIsOpen(nTr) )
    {
      /* This row is already open - close it */
      this.src = "../media/images/details_open.png";
      oTable.fnClose( nTr );
    }
    else
    {
      /* Open this row */
      this.src = "../media/images/details_close.png";
      oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
    }
  } );
} );
