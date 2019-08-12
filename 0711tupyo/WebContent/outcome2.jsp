<meta http-equiv="Content-Type" content="text/html; charset=utf-8" pageEncoding="utf8"/>
<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
  <head>
<%
   Class.forName("com.mysql.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopo05",
			"root","dc190105");
   Statement stmt = conn.createStatement();
   
   ResultSet rset = stmt.executeQuery("SELECT a.id, b.name, a.dp "+
   "FROM (SELECT id, COUNT(id) AS dp FROM tupyo_table GROUP BY id) AS a "+
   "JOIN (SELECT id, NAME FROM hubo_table) AS b ON a.id = b.id;");
%>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);
   
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', '후보번호,후보명');
        data.addColumn('number', '득표수');
      
      data.addRows([

<%
   while (rset.next()){      
%>
      ['<%=rset.getInt(1)+"번 "+rset.getString(2)%>',<%=rset.getInt(3)%>]   
<%
      if(rset.isLast())break;
            out.print(",");
      };
%>
        ]);
        // Set chart options
        var options = {'title':'개표결과',
                       'width':600,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      google.visualization.events.addListener(chart, 'click', (e) => {
         console.log('click', e.targetID);
         console.log('click', e.targetID.includes('vAxis'));
         if (e.targetID.includes('vAxis')) {
            const label = e.targetID;
            const label_id = label.split('#')[3];
            const id = Number(label_id) + 1;
            window.location = "./oneresult.jsp?id=" + id + "&name=" + data.wg[label_id].c[0].v.split(' ')[1];

         }
         
      });
      }
   
    </script>
</head>
<body>
    <!--Div that will hold the pie chart-->
   <div id="chart_div"></div>
</body>
</html>