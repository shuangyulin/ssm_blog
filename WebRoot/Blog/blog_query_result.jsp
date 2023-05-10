<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/blog.css" /> 

<div id="blog_manage"></div>
<div id="blog_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="blog_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="blog_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="blog_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="blog_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="blog_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="blogQueryForm" method="post">
			博客分类：<input class="textbox" type="text" id="blogClassObj_blogClassId_query" name="blogClassObj.blogClassId" style="width: auto"/>
			博客标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			发布用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			审核状态：<input type="text" class="textbox" id="shzt" name="shzt" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="blog_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="blogEditDiv">
	<form id="blogEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">博客id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_blogId_edit" name="blog.blogId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">博客分类:</span>
			<span class="inputControl">
				<input class="textbox"  id="blog_blogClassObj_blogClassId_edit" name="blog.blogClassObj.blogClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">博客标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_title_edit" name="blog.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">博客图片:</span>
			<span class="inputControl">
				<img id="blog_blogPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="blog_blogPhoto" name="blog.blogPhoto"/>
				<input id="blogPhotoFile" name="blogPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">博客内容:</span>
			<span class="inputControl">
				<script name="blog.content" id="blog_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">浏览量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_hitNum_edit" name="blog.hitNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="blog_userObj_user_name_edit" name="blog.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_addTime_edit" name="blog.addTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_shzt_edit" name="blog.shzt" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var blog_content_editor = UE.getEditor('blog_content_edit'); //博客内容编辑器
</script>
<script type="text/javascript" src="Blog/js/blog_manage.js"></script> 
