<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/blogClass.css" />
<div id="blogClass_editDiv">
	<form id="blogClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">博客分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blogClass_blogClassId_edit" name="blogClass.blogClassId" value="<%=request.getParameter("blogClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">博客分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="blogClass_blogClassName_edit" name="blogClass.blogClassName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">博客分类介绍:</span>
			<span class="inputControl">
				<textarea id="blogClass_blogClassDesc_edit" name="blogClass.blogClassDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="blogClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BlogClass/js/blogClass_modify.js"></script> 
