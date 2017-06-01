<%@ page language="java" import="java.util.*, java.sql.*, java.text.ParseException, java.text.SimpleDateFormat,com.db.Run" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--<meta name="viewport" content="width=device-width, initial-scale=1">-->
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>订购车票</title>
    <!-- Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <style type="text/css">
    tr>th>ul, tr>td>ul{
        list-style-type: none;
        padding-left: 0;
        margin-bottom: 0;
    }

    td>button{
        width: 60%
    }

    .table>thead>tr{
        background: linear-gradient(to bottom, #389cd8, #2386d6,#389cd8);
    }
    
    .table>tbody>tr>td {
        text-align: center;
        vertical-align: middle;
    }

    .table>thead>tr>th{
        text-align: center;
        vertical-align: middle;
        color: white;
    }
    </style>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING:Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <nav class="navbar">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="./index.html"><img src="./logo.png" class="navbar-brand" /></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="./index.html">首页</a></li>
                    <li><a href="./book.html">订购车票</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="./login.html"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
                    <li><a href="./register.html"><span class="glyphicon glyphicon-registration-mark"></span> 注册</a></li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-primary">
                    <div class="panel-content">
                        <div class="row" style="padding-top: 4px; padding-bottom: 4px">
                            <div class="col-xs-1 text-right" style="border-right: 1px solid #337ab7">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="travel_type" value="single" checked> 单程
                                    </label>
                                </div>
                                <div class="radio">
                                    <label class="radio">
                                        <input type="radio" name="travel_type" value="double"> 往返
                                    </label>
                                </div>
                            </div>
                            <form action="Search" method="POST">
                            <div class="col-xs-9" style="height: 65px">
                                <div class="row" style="padding-top: 15px; padding-right: 15px">
                                    <div class="col-xs-3" style="padding-right: 0">
                                        <label for="departure" class="control-label">出发地</label>
                                        <input type="text" class="form-control" id="departure" name="departure" placeholder="出发地" style="width:150px; display: inline">
                                    </div>
                                    <div class="col-xs-3" style="padding-right: 0">
                                        <label for="arrival">目的地</label>
                                        <input type="text" class="form-control" id="arrival" name="arrival" placeholder="目的地" style="width:150px; display: inline">
                                    </div>
                                    <div class="col-xs-3" style="padding-right: 0">
                                        <label for="departure_time">出发日</label>
                                        <input type="text" class="form-control" id="departure_time" name="departure_time" placeholder="出发时间" style="width:150px; display: inline">
                                    </div>
                                    <div class="col-xs-3" style="padding-right: 0">
                                        <label for="arrival_time">返程日</label>
                                        <input type="text" class="form-control" id="return_time" placeholder="到达时间" style="width:150px; display: inline">
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-2 text-center" style="border-left: 1px solid #337ab7; padding-right: 20px">
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="ticket_type" value="adult" checked> 普通
                                    </label>
                                </div>
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="ticket_type" value="student"> 学生
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-warning btn-block center-block" style="width: 80%">查询
                                </button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <table class="table table-striped">
                    <caption>&nbsp</caption>
                    <thead>
                        <tr>
                            <th>车次</th>
                            <th>
                                <ul>
                                    <li>出发站</li>
                                    <li>到达站</li>
                                </ul>
                            </th>
                            <th>
                                <ul>
                                    <li>出发时间</li>
                                    <li>到达时间</li>
                                </ul>
                            </th>
                            <th>历时</th>
                            <th>一等座</th>
                            <th>二等座</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <%
                    	ArrayList tripList = (ArrayList)request.getAttribute("tripList");
                                                            if (tripList != null) {
                                                            	Run trip = null;
                    %>
                    <tbody>
                    <%
                    	for (int i = 0; i < tripList.size(); ++i) {
                                                            		trip = (Run)tripList.get(i);
                    %>
                        <tr>
                            <td><%=trip.getTrainID() %></td>
                            <td>
                                <ul>
                                    <li><%=session.getAttribute("departure") %></li>
                                    <li><%=session.getAttribute("arrival") %></li>
                                </ul>
                            </td>
                            <td>
                                <ul>
                                    <li><%=trip.getDepartureTime() %></li>
                                    <li style="color: grey"><%=trip.getArrivalTime() %></li>
                                </ul>
                            </td>
                            <!-- <td><%=new SimpleDateFormat("hh:mm:ss").format(new java.util.Date((trip.getArrivalTime().getTime() - trip.getDepartureTime().getTime()))) %></td> -->
                            <% 
                            	long time_diff = trip.getArrivalTime().getTime() - trip.getDepartureTime().getTime();
                            	SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");
                            	time.setTimeZone(TimeZone.getTimeZone("GMT+0"));
                            %>
                            <td><%=time.format(time_diff) %></td>
                            <td><%="¥" + trip.getStationNum() * 50 %></td>
                            <td><%="¥" + trip.getStationNum() * 30 %></td>
                            <td><button type="submit" class="btn btn-warning">预定</button></td>
                        </tr>
                    <% 
                    	}
                    %>
                    </tbody>
                    <% 
                    }
                    %>
            </div>
        </div>
    </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/moment.js/2.18.1/moment-with-locales.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript">
    $(function() {
        $("#departure_time").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN'
        });
        $("#return_time").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN'
        });
    });
    </script>
</body>

</html>