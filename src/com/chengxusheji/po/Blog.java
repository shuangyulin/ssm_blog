package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Blog {
    /*博客id*/
    private Integer blogId;
    public Integer getBlogId(){
        return blogId;
    }
    public void setBlogId(Integer blogId){
        this.blogId = blogId;
    }

    /*博客分类*/
    private BlogClass blogClassObj;
    public BlogClass getBlogClassObj() {
        return blogClassObj;
    }
    public void setBlogClassObj(BlogClass blogClassObj) {
        this.blogClassObj = blogClassObj;
    }

    /*博客标题*/
    @NotEmpty(message="博客标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*博客图片*/
    private String blogPhoto;
    public String getBlogPhoto() {
        return blogPhoto;
    }
    public void setBlogPhoto(String blogPhoto) {
        this.blogPhoto = blogPhoto;
    }

    /*博客内容*/
    @NotEmpty(message="博客内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*浏览量*/
    @NotNull(message="必须输入浏览量")
    private Integer hitNum;
    public Integer getHitNum() {
        return hitNum;
    }
    public void setHitNum(Integer hitNum) {
        this.hitNum = hitNum;
    }

    /*发布用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shzt;
    public String getShzt() {
        return shzt;
    }
    public void setShzt(String shzt) {
        this.shzt = shzt;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBlog=new JSONObject(); 
		jsonBlog.accumulate("blogId", this.getBlogId());
		jsonBlog.accumulate("blogClassObj", this.getBlogClassObj().getBlogClassName());
		jsonBlog.accumulate("blogClassObjPri", this.getBlogClassObj().getBlogClassId());
		jsonBlog.accumulate("title", this.getTitle());
		jsonBlog.accumulate("blogPhoto", this.getBlogPhoto());
		jsonBlog.accumulate("content", this.getContent());
		jsonBlog.accumulate("hitNum", this.getHitNum());
		jsonBlog.accumulate("userObj", this.getUserObj().getName());
		jsonBlog.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonBlog.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		jsonBlog.accumulate("shzt", this.getShzt());
		return jsonBlog;
    }}