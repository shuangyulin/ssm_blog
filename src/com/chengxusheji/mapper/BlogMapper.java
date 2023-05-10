package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Blog;

public interface BlogMapper {
	/*添加博客信息*/
	public void addBlog(Blog blog) throws Exception;

	/*按照查询条件分页查询博客记录*/
	public ArrayList<Blog> queryBlog(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有博客记录*/
	public ArrayList<Blog> queryBlogList(@Param("where") String where) throws Exception;

	/*按照查询条件的博客记录数*/
	public int queryBlogCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条博客记录*/
	public Blog getBlog(int blogId) throws Exception;

	/*更新博客记录*/
	public void updateBlog(Blog blog) throws Exception;

	/*删除博客记录*/
	public void deleteBlog(int blogId) throws Exception;

}
