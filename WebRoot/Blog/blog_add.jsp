<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/blog.css" />
<div id="blogAddDiv">
	<form id="blogAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">博客分类:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_blogClassObj_blogClassId" name="blog.blogClassObj.blogClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">博客标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_title" name="blog.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">博客图片:</span>
			<span class="inputControl">
				<input id="blogPhotoFile" name="blogPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">博客内容:</span>
			<span class="inputControl">
				<script name="blog.content" id="blog_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">浏览量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_hitNum" name="blog.hitNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_userObj_user_name" name="blog.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_addTime" name="blog.addTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_shzt" name="blog.shzt" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="blogAddButton" class="easyui-linkbutton">添加</a>
			<a id="blogClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Blog/js/blog_add.js"></script> 
