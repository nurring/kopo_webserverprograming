<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
  <head>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
		"root","dc190105");
	Statement stmt = conn.createStatement();
	
	String QueryTxt;
	QueryTxt = String.format("SELECT a.id, b.NAME, a.dp "+
							"FROM (SELECT id, COUNT(id) AS dp FROM tupyo_table GROUP BY id) AS a "+
							"JOIN (SELECT id, NAME FROM hubo_table) AS b "+
							"ON a.id = b.id;");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      google.charts.load('current', {'packages':['corechart']});

      google.charts.setOnLoadCallback(drawChart);


      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['기호','link','득표수'],          
      <%  
          int count=0;
          while(rset.next()){
            count++;
            out.println("['"+rset.getInt(1)+"번 "+rset.getString(2)+"', './C_02.jsp?huboid="+rset.getInt(1)+"',"+rset.getInt(3)+"]");
            if(rset.isLast())break;
            out.print(",");  
         }
      %> 
        ]);           
        
        var groupData = google.visualization.data.group(
        	    data,
        	    [{column: 0, modifier: function () {return 'total'}, type:'string'}],
        	    [{column: 2, aggregation: google.visualization.data.sum, type: 'number'}]
        	  );
        
        var formatPercent = new google.visualization.NumberFormat({
            pattern: '#,##0.0%'
          });

          var formatShort = new google.visualization.NumberFormat({
            pattern: 'short'
          });

        var view = new google.visualization.DataView(data);
        //view.setColumns([0, 2]);
        view.setColumns([0, 2, {
	    calc: function (dt, row) {
	      var amount =  formatShort.formatValue(dt.getValue(row, 2));
	      var percent = formatPercent.formatValue(dt.getValue(row, 2) / groupData.getValue(0, 1));
	      return amount + ' (' + percent + ')';
	    },
	    type: 'string',
	    role: 'annotation'
	  	}]);
        
       
        // Set chart options
        var options = {'title':'후보 별 득표율',
                       'width':800,
                       'height':600,
                       //'annotations': {
                    	      //alwaysOutside: true
                    	    //}
        				};

        // Instantiate and draw our chart, passing in some options.
        // var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        // chart.draw(data, options);
        var chart = new google.visualization.BarChart(
          document.getElementById('chart_div'));
        chart.draw(view, options);

        // google.visualization.events.addListener(chart, 'select', selectHandler); 

        var selectHandler = function(e) {
         window.location = data.getValue(chart.getSelection()[0]['row'], 1 );
        }

         google.visualization.events.addListener(chart, 'select', selectHandler);
      }
      
    </script>
  </head>

  <body>
    <div id="chart_div"></div>
  </body>
</html>