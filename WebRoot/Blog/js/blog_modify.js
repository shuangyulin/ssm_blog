$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('blog_content_edit');
	var blog_content_edit = UE.getEditor('blog_content_edit'); //博客内容编辑器
	blog_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Blog/" + $("#blog_blogId_edit").val() + "/update",
		type : "get",
		data : {
			//blogId : $("#blog_blogId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (blog, response, status) {
			$.messager.progress("close");
			if (blog) { 
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
				blog_content_edit.setContent(blog.content);
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#blogModifyButton").click(function(){ 
		if ($("#blogEditForm").form("validate")) {
			$("#blogEditForm").form({
			    url:"Blog/" +  $("#blog_blogId_edit").val() + "/update",
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
			$("#blogEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
