<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BlogClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    BlogClass blogClass = (BlogClass)request.getAttribute("blogClass");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改博客分类信息</TITLE>
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
  		<li class="active">博客分类信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="blogClassEditForm" id="blogClassEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="blogClass_blogClassId_edit" class="col-md-3 text-right">博客分类id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="blogClass_blogClassId_edit" name="blogClass.blogClassId" class="form-control" placeholder="请输入博客分类id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="blogClass_blogClassName_edit" class="col-md-3 text-right">博客分类名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="blogClass_blogClassName_edit" name="blogClass.blogClassName" class="form-control" placeholder="请输入博客分类名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blogClass_blogClassDesc_edit" class="col-md-3 text-right">博客分类介绍:</label>
		  	 <div class="col-md-9">
			    <textarea id="blogClass_blogClassDesc_edit" name="blogClass.blogClassDesc" rows="8" class="form-control" placeholder="请输入博客分类介绍"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBlogClassModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#blogClassEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改博客分类界面并初始化数据*/
function blogClassEdit(blogClassId) {
	$.ajax({
		url :  basePath + "BlogClass/" + blogClassId + "/update",
		type : "get",
		dataType: "json",
		success : function (blogClass, response, status) {
			if (blogClass) {
				$("#blogClass_blogClassId_edit").val(blogClass.blogClassId);
				$("#blogClass_blogClassName_edit").val(blogClass.blogClassName);
				$("#blogClass_blogClassDesc_edit").val(blogClass.blogClassDesc);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交博客分类信息表单给服务器端修改*/
function ajaxBlogClassModify() {
	$.ajax({
		url :  basePath + "BlogClass/" + $("#blogClass_blogClassId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#blogClassEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "BlogClass/frontlist";
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
    blogClassEdit("<%=request.getParameter("blogClassId")%>");
 })
 </script> 
</body>
</html>

