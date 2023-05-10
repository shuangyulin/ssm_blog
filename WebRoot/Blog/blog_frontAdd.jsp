<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BlogClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>博客添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Blog/frontlist">博客管理</a></li>
  			<li class="active">添加博客</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="blogAddForm" id="blogAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="blog_blogClassObj_blogClassId" class="col-md-2 text-right">博客分类:</label>
				  	 <div class="col-md-8">
					    <select id="blog_blogClassObj_blogClassId" name="blog.blogClassObj.blogClassId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_title" class="col-md-2 text-right">博客标题:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="blog_title" name="blog.title" class="form-control" placeholder="请输入博客标题">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_blogPhoto" class="col-md-2 text-right">博客图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="blog_blogPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="blog_blogPhoto" name="blog.blogPhoto"/>
					    <input id="blogPhotoFile" name="blogPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_content" class="col-md-2 text-right">博客内容:</label>
				  	 <div class="col-md-8">
							    <textarea name="blog.content" id="blog_content" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_hitNum" class="col-md-2 text-right">浏览量:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="blog_hitNum" name="blog.hitNum" class="form-control" placeholder="请输入浏览量">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_userObj_user_name" class="col-md-2 text-right">发布用户:</label>
				  	 <div class="col-md-8">
					    <select id="blog_userObj_user_name" name="blog.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_addTimeDiv" class="col-md-2 text-right">发布时间:</label>
				  	 <div class="col-md-8">
		                <div id="blog_addTimeDiv" class="input-group date blog_addTime col-md-12" data-link-field="blog_addTime">
		                    <input class="form-control" id="blog_addTime" name="blog.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="blog_shzt" class="col-md-2 text-right">审核状态:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="blog_shzt" name="blog.shzt" class="form-control" placeholder="请输入审核状态">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxBlogAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#blogAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var blog_content_editor = UE.getEditor('blog_content'); //博客内容编辑器
var basePath = "<%=basePath%>";
	//提交添加博客信息
	function ajaxBlogAdd() { 
		//提交之前先验证表单
		$("#blogAddForm").data('bootstrapValidator').validate();
		if(!$("#blogAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(blog_content_editor.getContent() == "") {
			alert('博客内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Blog/add",
			dataType : "json" , 
			data: new FormData($("#blogAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#blogAddForm").find("input").val("");
					$("#blogAddForm").find("textarea").val("");
					blog_content_editor.setContent("");
				} else {
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
	//验证博客添加表单字段
	$('#blogAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"blog.title": {
				validators: {
					notEmpty: {
						message: "博客标题不能为空",
					}
				}
			},
			"blog.hitNum": {
				validators: {
					notEmpty: {
						message: "浏览量不能为空",
					},
					integer: {
						message: "浏览量不正确"
					}
				}
			},
			"blog.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
			"blog.shzt": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
					}
				}
			},
		}
	}); 
	//初始化博客分类下拉框值 
	$.ajax({
		url: basePath + "BlogClass/listAll",
		type: "get",
		success: function(blogClasss,response,status) { 
			$("#blog_blogClassObj_blogClassId").empty();
			var html="";
    		$(blogClasss).each(function(i,blogClass){
    			html += "<option value='" + blogClass.blogClassId + "'>" + blogClass.blogClassName + "</option>";
    		});
    		$("#blog_blogClassObj_blogClassId").html(html);
    	}
	});
	//初始化发布用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#blog_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#blog_userObj_user_name").html(html);
    	}
	});
	//发布时间组件
	$('#blog_addTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#blogAddForm').data('bootstrapValidator').updateStatus('blog.addTime', 'NOT_VALIDATED',null).validateField('blog.addTime');
	});
})
</script>
</body>
</html>
