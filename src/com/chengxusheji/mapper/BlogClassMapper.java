package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BlogClass;

public interface BlogClassMapper {
	/*添加博客分类信息*/
	public void addBlogClass(BlogClass blogClass) throws Exception;

	/*按照查询条件分页查询博客分类记录*/
	public ArrayList<BlogClass> queryBlogClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有博客分类记录*/
	public ArrayList<BlogClass> queryBlogClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的博客分类记录数*/
	public int queryBlogClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条博客分类记录*/
	public BlogClass getBlogClass(int blogClassId) throws Exception;

	/*更新博客分类记录*/
	public void updateBlogClass(BlogClass blogClass) throws Exception;

	/*删除博客分类记录*/
	public void deleteBlogClass(int blogClassId) throws Exception;

}
