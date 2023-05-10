<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>博客分类添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>BlogClass/frontlist">博客分类列表</a></li>
			    	<li role="presentation" class="active"><a href="#blogClassAdd" aria-controls="blogClassAdd" role="tab" data-toggle="tab">添加博客分类</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="blogClassList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="blogClassAdd"> 
				      	<form class="form-horizontal" name="blogClassAddForm" id="blogClassAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="blogClass_blogClassName" class="col-md-2 text-right">博客分类名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="blogClass_blogClassName" name="blogClass.blogClassName" class="form-control" placeholder="请输入博客分类名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="blogClass_blogClassDesc" class="col-md-2 text-right">博客分类介绍:</label>
						  	 <div class="col-md-8">
							    <textarea id="blogClass_blogClassDesc" name="blogClass.blogClassDesc" rows="8" class="form-control" placeholder="请输入博客分类介绍"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxBlogClassAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#blogClassAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
<script>
var basePath = "<%=basePath%>";
	//提交添加博客分类信息
	function ajaxBlogClassAdd() { 
		//提交之前先验证表单
		$("#blogClassAddForm").data('bootstrapValidator').validate();
		if(!$("#blogClassAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BlogClass/add",
			dataType : "json" , 
			data: new FormData($("#blogClassAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#blogClassAddForm").find("input").val("");
					$("#blogClassAddForm").find("textarea").val("");
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
	//验证博客分类添加表单字段
	$('#blogClassAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"blogClass.blogClassName": {
				validators: {
					notEmpty: {
						message: "博客分类名称不能为空",
					}
				}
			},
			"blogClass.blogClassDesc": {
				validators: {
					notEmpty: {
						message: "博客分类介绍不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
