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
	
	String huboid = request.getParameter("huboid");
	int id = Integer.parseInt(huboid);
	
	String QueryTxt;
	QueryTxt = String.format("SELECT a.id, b.NAME, a.age, a.counting "+
			"FROM (SELECT id, age, COUNT(age)AS counting FROM tupyo_table WHERE id = "+id+
			" GROUP BY age) AS a "+
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
            out.println("['"+rset.getInt(3)+"대 ', '',"+rset.getInt(4)+"]");
            if(rset.isLast())break;
            out.print(",");  
         }
      %> 

          
        ]);           

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 2]);
        
       
        // Set chart options
        var options = {'title':'연령 별 득표',
                       'width':800,
                       'height':600};

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