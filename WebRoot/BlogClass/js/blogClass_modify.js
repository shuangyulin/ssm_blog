$(function () {
	$.ajax({
		url : "BlogClass/" + $("#blogClass_blogClassId_edit").val() + "/update",
		type : "get",
		data : {
			//blogClassId : $("#blogClass_blogClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (blogClass, response, status) {
			$.messager.progress("close");
			if (blogClass) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#blogClassModifyButton").click(function(){ 
		if ($("#blogClassEditForm").form("validate")) {
			$("#blogClassEditForm").form({
			    url:"BlogClass/" +  $("#blogClass_blogClassId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#blogClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
