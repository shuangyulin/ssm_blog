var blogClass_manage_tool = null; 
$(function () { 
	initBlogClassManageTool(); //建立BlogClass管理对象
	blogClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#blogClass_manage").datagrid({
		url : 'BlogClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "blogClassId",
		sortOrder : "desc",
		toolbar : "#blogClass_manage_tool",
		columns : [[
			{
				field : "blogClassId",
				title : "博客分类id",
				width : 70,
			},
			{
				field : "blogClassName",
				title : "博客分类名称",
				width : 140,
			},
			{
				field : "blogClassDesc",
				title : "博客分类介绍",
				width : 140,
			},
		]],
	});

	$("#blogClassEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#blogClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#blogClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#blogClassEditForm").form({
						    url:"BlogClass/" + $("#blogClass_blogClassId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#blogClassEditForm").form("validate"))  {
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
			                        $("#blogClassEditDiv").dialog("close");
			                        blogClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#blogClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#blogClassEditDiv").dialog("close");
				$("#blogClassEditForm").form("reset"); 
			},
		}],
	});
});

function initBlogClassManageTool() {
	blogClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#blogClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#blogClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#blogClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#blogClassQueryForm").form({
			    url:"BlogClass/OutToExcel",
			});
			//提交表单
			$("#blogClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#blogClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var blogClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							blogClassIds.push(rows[i].blogClassId);
						}
						$.ajax({
							type : "POST",
							url : "BlogClass/deletes",
							data : {
								blogClassIds : blogClassIds.join(","),
							},
							beforeSend : function () {
								$("#blogClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#blogClass_manage").datagrid("loaded");
									$("#blogClass_manage").datagrid("load");
									$("#blogClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#blogClass_manage").datagrid("loaded");
									$("#blogClass_manage").datagrid("load");
									$("#blogClass_manage").datagrid("unselectAll");
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
			var rows = $("#blogClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BlogClass/" + rows[0].blogClassId +  "/update",
					type : "get",
					data : {
						//blogClassId : rows[0].blogClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (blogClass, response, status) {
						$.messager.progress("close");
						if (blogClass) { 
							$("#blogClassEditDiv").dialog("open");
							$("#blogClass_blogClassId_edit").val(blogClass.blogClassId);
							$("#blogClass_blogClassId_edit").validatebox({
								required : true,
								missingMessage : "请输入博客分类id",
								editable: false
							});
							$("#blogClass_blogClassName_edit").val(blogClass.blogClassName);
							$("#blogClass_blogClassName_edit").validatebox({
								required : true,
								missingMessage : "请输入博客分类名称",
							});
							$("#blogClass_blogClassDesc_edit").val(blogClass.blogClassDesc);
							$("#blogClass_blogClassDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入博客分类介绍",
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
