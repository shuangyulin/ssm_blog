var blog_manage_tool = null; 
$(function () { 
	initBlogManageTool(); //建立Blog管理对象
	blog_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#blog_manage").datagrid({
		url : 'Blog/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "blogId",
		sortOrder : "desc",
		toolbar : "#blog_manage_tool",
		columns : [[
			{
				field : "blogId",
				title : "博客id",
				width : 70,
			},
			{
				field : "blogClassObj",
				title : "博客分类",
				width : 140,
			},
			{
				field : "title",
				title : "博客标题",
				width : 140,
			},
			{
				field : "blogPhoto",
				title : "博客图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "hitNum",
				title : "浏览量",
				width : 70,
			},
			{
				field : "userObj",
				title : "发布用户",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
			{
				field : "shzt",
				title : "审核状态",
				width : 140,
			},
		]],
	});

	$("#blogEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#blogEditForm").form("validate")) {
					//验证表单 
					if(!$("#blogEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#blogEditForm").form({
						    url:"Blog/" + $("#blog_blogId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#blogEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#blogEditDiv").dialog("close");
			                        blog_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#blogEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#blogEditDiv").dialog("close");
				$("#blogEditForm").form("reset"); 
			},
		}],
	});
});

function initBlogManageTool() {
	blog_manage_tool = {
		init: function() {
			$.ajax({
				url : "BlogClass/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#blogClassObj_blogClassId_query").combobox({ 
					    valueField:"blogClassId",
					    textField:"blogClassName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{blogClassId:0,blogClassName:"不限制"});
					$("#blogClassObj_blogClassId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#blog_manage").datagrid("reload");
		},
		redo : function () {
			$("#blog_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#blog_manage").datagrid("options").queryParams;
			queryParams["blogClassObj.blogClassId"] = $("#blogClassObj_blogClassId_query").combobox("getValue");
			queryParams["title"] = $("#title").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			queryParams["shzt"] = $("#shzt").val();
			$("#blog_manage").datagrid("options").queryParams=queryParams; 
			$("#blog_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#blogQueryForm").form({
			    url:"Blog/OutToExcel",
			});
			//提交表单
			$("#blogQueryForm").submit();
		},
		remove : function () {
			var rows = $("#blog_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var blogIds = [];
						for (var i = 0; i < rows.length; i ++) {
							blogIds.push(rows[i].blogId);
						}
						$.ajax({
							type : "POST",
							url : "Blog/deletes",
							data : {
								blogIds : blogIds.join(","),
							},
							beforeSend : function () {
								$("#blog_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#blog_manage").datagrid("loaded");
									$("#blog_manage").datagrid("load");
									$("#blog_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#blog_manage").datagrid("loaded");
									$("#blog_manage").datagrid("load");
									$("#blog_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#blog_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Blog/" + rows[0].blogId +  "/update",
					type : "get",
					data : {
						//blogId : rows[0].blogId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (blog, response, status) {
						$.messager.progress("close");
						if (blog) { 
							$("#blogEditDiv").dialog("open");
							$("#blog_blogId_edit").val(blog.blogId);
							$("#blog_blogId_edit").validatebox({
								required : true,
								missingMessage : "请输入博客id",
								editable: false
							});
							$("#blog_blogClassObj_blogClassId_edit").combobox({
								url:"BlogClass/listAll",
							    valueField:"blogClassId",
							    textField:"blogClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#blog_blogClassObj_blogClassId_edit").combobox("select", blog.blogClassObjPri);
									//var data = $("#blog_blogClassObj_blogClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#blog_blogClassObj_blogClassId_edit").combobox("select", data[0].blogClassId);
						            //}
								}
							});
							$("#blog_title_edit").val(blog.title);
							$("#blog_title_edit").validatebox({
								required : true,
								missingMessage : "请输入博客标题",
							});
							$("#blog_blogPhoto").val(blog.blogPhoto);
							$("#blog_blogPhotoImg").attr("src", blog.blogPhoto);
							blog_content_editor.setContent(blog.content, false);
							$("#blog_hitNum_edit").val(blog.hitNum);
							$("#blog_hitNum_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入浏览量",
								invalidMessage : "浏览量输入不对",
							});
							$("#blog_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#blog_userObj_user_name_edit").combobox("select", blog.userObjPri);
									//var data = $("#blog_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#blog_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#blog_addTime_edit").datetimebox({
								value: blog.addTime,
							    required: true,
							    showSeconds: true,
							});
							$("#blog_shzt_edit").val(blog.shzt);
							$("#blog_shzt_edit").validatebox({
								required : true,
								missingMessage : "请输入审核状态",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
