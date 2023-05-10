<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/blogClass.css" />
<div id="blogClassAddDiv">
	<form id="blogClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">博客分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blogClass_blogClassName" name="blogClass.blogClassName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">博客分类介绍:</span>
			<span class="inputControl">
				<textarea id="blogClass_blogClassDesc" name="blogClass.blogClassDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="blogClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="blogClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BlogClass/js/blogClass_add.js"></script> 
