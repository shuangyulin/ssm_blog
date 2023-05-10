<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Blog" %>
<%@ page import="com.chengxusheji.po.BlogClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的blogClassObj信息
    List<BlogClass> blogClassList = (List<BlogClass>)request.getAttribute("blogClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Blog blog = (Blog)request.getAttribute("blog");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改博客信息</TITLE>
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
  		<li class="active">博客信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="blogEditForm" id="blogEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="blog_blogId_edit" class="col-md-3 text-right">博客id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="blog_blogId_edit" name="blog.blogId" class="form-control" placeholder="请输入博客id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="blog_blogClassObj_blogClassId_edit" class="col-md-3 text-right">博客分类:</label>
		  	 <div class="col-md-9">
			    <select id="blog_blogClassObj_blogClassId_edit" name="blog.blogClassObj.blogClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_title_edit" class="col-md-3 text-right">博客标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="blog_title_edit" name="blog.title" class="form-control" placeholder="请输入博客标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_blogPhoto_edit" class="col-md-3 text-right">博客图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="blog_blogPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="blog_blogPhoto" name="blog.blogPhoto"/>
			    <input id="blogPhotoFile" name="blogPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_content_edit" class="col-md-3 text-right">博客内容:</label>
		  	 <div class="col-md-9">
			    <script name="blog.content" id="blog_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_hitNum_edit" class="col-md-3 text-right">浏览量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="blog_hitNum_edit" name="blog.hitNum" class="form-control" placeholder="请输入浏览量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_userObj_user_name_edit" class="col-md-3 text-right">发布用户:</label>
		  	 <div class="col-md-9">
			    <select id="blog_userObj_user_name_edit" name="blog.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date blog_addTime_edit col-md-12" data-link-field="blog_addTime_edit">
                    <input class="form-control" id="blog_addTime_edit" name="blog.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="blog_shzt_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="blog_shzt_edit" name="blog.shzt" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBlogModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#blogEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var blog_content_editor = UE.getEditor('blog_content_edit'); //博客内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改博客界面并初始化数据*/
function blogEdit(blogId) {
  blog_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(blogId);
  });
}
 function ajaxModifyQuery(blogId) {
	$.ajax({
		url :  basePath + "Blog/" + blogId + "/update",
		type : "get",
		dataType: "json",
		success : function (blog, response, status) {
			if (blog) {
				$("#blog_blogId_edit").val(blog.blogId);
				$.ajax({
					url: basePath + "BlogClass/listAll",
					type: "get",
					success: function(blogClasss,response,status) { 
						$("#blog_blogClassObj_blogClassId_edit").empty();
						var html="";
		        		$(blogClasss).each(function(i,blogClass){
		        			html += "<option value='" + blogClass.blogClassId + "'>" + blogClass.blogClassName + "</option>";
		        		});
		        		$("#blog_blogClassObj_blogClassId_edit").html(html);
		        		$("#blog_blogClassObj_blogClassId_edit").val(blog.blogClassObjPri);
					}
				});
				$("#blog_title_edit").val(blog.title);
				$("#blog_blogPhoto").val(blog.blogPhoto);
				$("#blog_blogPhotoImg").attr("src", basePath +　blog.blogPhoto);
				blog_content_editor.setContent(blog.content, false);
				$("#blog_hitNum_edit").val(blog.hitNum);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#blog_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#blog_userObj_user_name_edit").html(html);
		        		$("#blog_userObj_user_name_edit").val(blog.userObjPri);
					}
				});
				$("#blog_addTime_edit").val(blog.addTime);
				$("#blog_shzt_edit").val(blog.shzt);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交博客信息表单给服务器端修改*/
function ajaxBlogModify() {
	$.ajax({
		url :  basePath + "Blog/" + $("#blog_blogId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#blogEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#blogQueryForm").submit();
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
    /*发布时间组件*/
    $('.blog_addTime_edit').datetimepicker({
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
    blogEdit("<%=request.getParameter("blogId")%>");
 })
 </script> 
</body>
</html>

