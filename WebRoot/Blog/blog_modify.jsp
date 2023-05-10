<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/blog.css" />
<div id="blog_editDiv">
	<form id="blogEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">博客id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blog_blogId_edit" name="blog.blogId" value="<%=request.getParameter("blogId") %>" style="width:200px" />
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
				<script id="blog_content_edit" name="blog.content" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="blogModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Blog/js/blog_modify.js"></script> 
