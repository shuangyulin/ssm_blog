package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BlogClass {
    /*博客分类id*/
    private Integer blogClassId;
    public Integer getBlogClassId(){
        return blogClassId;
    }
    public void setBlogClassId(Integer blogClassId){
        this.blogClassId = blogClassId;
    }

    /*博客分类名称*/
    @NotEmpty(message="博客分类名称不能为空")
    private String blogClassName;
    public String getBlogClassName() {
        return blogClassName;
    }
    public void setBlogClassName(String blogClassName) {
        this.blogClassName = blogClassName;
    }

    /*博客分类介绍*/
    @NotEmpty(message="博客分类介绍不能为空")
    private String blogClassDesc;
    public String getBlogClassDesc() {
        return blogClassDesc;
    }
    public void setBlogClassDesc(String blogClassDesc) {
        this.blogClassDesc = blogClassDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBlogClass=new JSONObject(); 
		jsonBlogClass.accumulate("blogClassId", this.getBlogClassId());
		jsonBlogClass.accumulate("blogClassName", this.getBlogClassName());
		jsonBlogClass.accumulate("blogClassDesc", this.getBlogClassDesc());
		return jsonBlogClass;
    }}