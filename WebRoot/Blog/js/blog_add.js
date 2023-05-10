$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('blog_content');
	var blog_content_editor = UE.getEditor('blog_content'); //博客内容编辑框
	$("#blog_blogClassObj_blogClassId").combobox({
	    url:'BlogClass/listAll',
	    valueField: "blogClassId",
	    textField: "blogClassName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#blog_blogClassObj_blogClassId").combobox("getData"); 
            if (data.length > 0) {
                $("#blog_blogClassObj_blogClassId").combobox("select", data[0].blogClassId);
            }
        }
	});
	$("#blog_title").validatebox({
		required : true, 
		missingMessage : '请输入博客标题',
	});

	$("#blog_hitNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入浏览量',
		invalidMessage : '浏览量输入不对',
	});

	$("#blog_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#blog_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#blog_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#blog_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#blog_shzt").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	//单击添加按钮
	$("#blogAddButton").click(function () {
		if(blog_content_editor.getContent() == "") {
			alert("请输入博客内容");
			return;
		}
		//验证表单 
		if(!$("#blogAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#blogAddForm").form({
			    url:"Blog/add",
			    onSubmit: function(){
					if($("#blogAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#blogAddForm").form("clear");
                        blog_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#blogAddForm").submit();
		}
	});

	//单击清空按钮
	$("#blogClearButton").click(function () { 
		$("#blogAddForm").form("clear"); 
	});
});
