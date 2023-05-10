<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Comment" %>
<%@ page import="com.chengxusheji.po.Blog" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的blogObj信息
    List<Blog> blogList = (List<Blog>)request.getAttribute("blogList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Comment comment = (Comment)request.getAttribute("comment");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改博客评论信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">博客评论信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="commentEditForm" id="commentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="comment_commentId_edit" class="col-md-3 text-right">回复id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="comment_commentId_edit" name="comment.commentId" class="form-control" placeholder="请输入回复id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="comment_blogObj_blogId_edit" class="col-md-3 text-right">被评博客:</label>
		  	 <div class="col-md-9">
			    <select id="comment_blogObj_blogId_edit" name="comment.blogObj.blogId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="comment_content_edit" class="col-md-3 text-right">评论内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="comment_content_edit" name="comment.content" rows="8" class="form-control" placeholder="请输入评论内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="comment_userObj_user_name_edit" class="col-md-3 text-right">评论人:</label>
		  	 <div class="col-md-9">
			    <select id="comment_userObj_user_name_edit" name="comment.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="comment_commentTime_edit" class="col-md-3 text-right">评论时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date comment_commentTime_edit col-md-12" data-link-field="comment_commentTime_edit">
                    <input class="form-control" id="comment_commentTime_edit" name="comment.commentTime" size="16" type="text" value="" placeholder="请选择评论时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCommentModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#commentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改博客评论界面并初始化数据*/
function commentEdit(commentId) {
	$.ajax({
		url :  basePath + "Comment/" + commentId + "/update",
		type : "get",
		dataType: "json",
		success : function (comment, response, status) {
			if (comment) {
				$("#comment_commentId_edit").val(comment.commentId);
				$.ajax({
					url: basePath + "Blog/listAll",
					type: "get",
					success: function(blogs,response,status) { 
						$("#comment_blogObj_blogId_edit").empty();
						var html="";
		        		$(blogs).each(function(i,blog){
		        			html += "<option value='" + blog.blogId + "'>" + blog.title + "</option>";
		        		});
		        		$("#comment_blogObj_blogId_edit").html(html);
		        		$("#comment_blogObj_blogId_edit").val(comment.blogObjPri);
					}
				});
				$("#comment_content_edit").val(comment.content);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#comment_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#comment_userObj_user_name_edit").html(html);
		        		$("#comment_userObj_user_name_edit").val(comment.userObjPri);
					}
				});
				$("#comment_commentTime_edit").val(comment.commentTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交博客评论信息表单给服务器端修改*/
function ajaxCommentModify() {
	$.ajax({
		url :  basePath + "Comment/" + $("#comment_commentId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#commentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#commentQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*评论时间组件*/
    $('.comment_commentTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    commentEdit("<%=request.getParameter("commentId")%>");
 })
 </script> 
</body>
</html>

