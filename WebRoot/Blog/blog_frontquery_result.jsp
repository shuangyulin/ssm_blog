<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Blog" %>
<%@ page import="com.chengxusheji.po.BlogClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Blog> blogList = (List<Blog>)request.getAttribute("blogList");
    //获取所有的blogClassObj信息
    List<BlogClass> blogClassList = (List<BlogClass>)request.getAttribute("blogClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    BlogClass blogClassObj = (BlogClass)request.getAttribute("blogClassObj");
    String title = (String)request.getAttribute("title"); //博客标题查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
    String shzt = (String)request.getAttribute("shzt"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>博客查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Blog/frontlist">博客信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Blog/blog_frontAdd.jsp" style="display:none;">添加博客</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<blogList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Blog blog = blogList.get(i); //获取到博客对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Blog/<%=blog.getBlogId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=blog.getBlogPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		博客id:<%=blog.getBlogId() %>
			     	</div>
			     	<div class="field">
	            		博客分类:<%=blog.getBlogClassObj().getBlogClassName() %>
			     	</div>
			     	<div class="field">
	            		博客标题:<%=blog.getTitle() %>
			     	</div>
			     	<div class="field">
	            		浏览量:<%=blog.getHitNum() %>
			     	</div>
			     	<div class="field">
	            		发布用户:<%=blog.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=blog.getAddTime() %>
			     	</div>
			     	<div class="field">
	            		审核状态:<%=blog.getShzt() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Blog/<%=blog.getBlogId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="blogEdit('<%=blog.getBlogId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="blogDelete('<%=blog.getBlogId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>博客查询</h1>
		</div>
		<form name="blogQueryForm" id="blogQueryForm" action="<%=basePath %>Blog/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="blogClassObj_blogClassId">博客分类：</label>
                <select id="blogClassObj_blogClassId" name="blogClassObj.blogClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(BlogClass blogClassTemp:blogClassList) {
	 					String selected = "";
 					if(blogClassObj!=null && blogClassObj.getBlogClassId()!=null && blogClassObj.getBlogClassId().intValue()==blogClassTemp.getBlogClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=blogClassTemp.getBlogClassId() %>" <%=selected %>><%=blogClassTemp.getBlogClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="title">博客标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入博客标题">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">发布用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="shzt">审核状态:</label>
				<input type="text" id="shzt" name="shzt" value="<%=shzt %>" class="form-control" placeholder="请输入审核状态">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="blogEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;博客信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="blog.content" id="blog_content_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#blogEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxBlogModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var blog_content_edit = UE.getEditor('blog_content_edit'); //博客内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.blogQueryForm.currentPage.value = currentPage;
    document.blogQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.blogQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.blogQueryForm.currentPage.value = pageValue;
    documentblogQueryForm.submit();
}

/*弹出修改博客界面并初始化数据*/
function blogEdit(blogId) {
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
				blog_content_edit.setContent(blog.content, false);
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
				$('#blogEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除博客信息*/
function blogDelete(blogId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Blog/deletes",
			data : {
				blogIds : blogId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#blogQueryForm").submit();
					//location.href= basePath + "Blog/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

