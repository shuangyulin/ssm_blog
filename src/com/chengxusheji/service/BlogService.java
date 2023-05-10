package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BlogClass;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Blog;

import com.chengxusheji.mapper.BlogMapper;
@Service
public class BlogService {

	@Resource BlogMapper blogMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加博客记录*/
    public void addBlog(Blog blog) throws Exception {
    	blogMapper.addBlog(blog);
    }

    /*按照查询条件分页查询博客记录*/
    public ArrayList<Blog> queryBlog(BlogClass blogClassObj,String title,UserInfo userObj,String addTime,String shzt,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != blogClassObj && blogClassObj.getBlogClassId()!= null && blogClassObj.getBlogClassId()!= 0)  where += " and t_blog.blogClassObj=" + blogClassObj.getBlogClassId();
    	if(!title.equals("")) where = where + " and t_blog.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_blog.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_blog.addTime like '%" + addTime + "%'";
    	if(!shzt.equals("")) where = where + " and t_blog.shzt like '%" + shzt + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return blogMapper.queryBlog(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Blog> queryBlog(BlogClass blogClassObj,String title,UserInfo userObj,String addTime,String shzt) throws Exception  { 
     	String where = "where 1=1";
    	if(null != blogClassObj && blogClassObj.getBlogClassId()!= null && blogClassObj.getBlogClassId()!= 0)  where += " and t_blog.blogClassObj=" + blogClassObj.getBlogClassId();
    	if(!title.equals("")) where = where + " and t_blog.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_blog.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_blog.addTime like '%" + addTime + "%'";
    	if(!shzt.equals("")) where = where + " and t_blog.shzt like '%" + shzt + "%'";
    	return blogMapper.queryBlogList(where);
    }

    /*查询所有博客记录*/
    public ArrayList<Blog> queryAllBlog()  throws Exception {
        return blogMapper.queryBlogList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(BlogClass blogClassObj,String title,UserInfo userObj,String addTime,String shzt) throws Exception {
     	String where = "where 1=1";
    	if(null != blogClassObj && blogClassObj.getBlogClassId()!= null && blogClassObj.getBlogClassId()!= 0)  where += " and t_blog.blogClassObj=" + blogClassObj.getBlogClassId();
    	if(!title.equals("")) where = where + " and t_blog.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_blog.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_blog.addTime like '%" + addTime + "%'";
    	if(!shzt.equals("")) where = where + " and t_blog.shzt like '%" + shzt + "%'";
        recordNumber = blogMapper.queryBlogCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取博客记录*/
    public Blog getBlog(int blogId) throws Exception  {
        Blog blog = blogMapper.getBlog(blogId);
        return blog;
    }

    /*更新博客记录*/
    public void updateBlog(Blog blog) throws Exception {
        blogMapper.updateBlog(blog);
    }

    /*删除一条博客记录*/
    public void deleteBlog (int blogId) throws Exception {
        blogMapper.deleteBlog(blogId);
    }

    /*删除多条博客信息*/
    public int deleteBlogs (String blogIds) throws Exception {
    	String _blogIds[] = blogIds.split(",");
    	for(String _blogId: _blogIds) {
    		blogMapper.deleteBlog(Integer.parseInt(_blogId));
    	}
    	return _blogIds.length;
    }
}
